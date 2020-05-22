defmodule EDA do
  @moduledoc """
  Documentation for `EDA`.
  """

  require Logger

  @spec start_link(arg :: any) :: {:ok, pid}
  def start_link(arg \\ []) do
    Logger.debug("start_link(#{inspect(arg)})")
    Task.start_link(&EDA.infinite_receive_loop/0)
  end

  @doc """
  Performs a time-consuming computation (Bcrypt)
  """
  @spec compute(password :: String.t()) :: String.t()
  def compute(password \\ "correct horse battery staple") do
    {_, s} = res = :timer.tc(fn -> Bcrypt.hash_pwd_salt(password) end)
    Logger.debug(inspect(res))
    s
  end

  @doc """
  Just outputs "Hello, world!" if given no parameters.
  """
  @spec hello(who :: String.t()) :: String.t()
  def hello(who \\ "world") do
    s = "Hello, #{who}!"
    Logger.debug(s)
    s
  end

  @doc """
  An infinite receive loop
  """
  @spec infinite_receive_loop :: no_return
  def infinite_receive_loop() do
    receive do
      {:hello, who} -> hello(who)
      {:compute, s} -> compute(s)
      {:hello_reply, caller, who} -> send(caller, hello(who))
      {:compute_reply, caller, s} -> send(caller, compute(s))
      x -> Logger.debug(inspect(x))
    after
      30000 ->
        Logger.debug("Timeout after 5 seconds")
        :ok
    end

    infinite_receive_loop()
  end

  def receive do
    receive do
      msg -> IO.puts(inspect(msg))
    after
      500 -> IO.puts("Timeout")
    end
  end

  def compute_async_await_reply(pid, password) do
    send(pid, {:compute_reply, self(), password})

    receive do
      msg -> msg
    after
      5000 -> IO.puts("Timeout")
    end
  end
end
