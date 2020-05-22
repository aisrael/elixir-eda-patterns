defmodule EDA do
  @moduledoc """
  Documentation for `EDA`.
  """

  require Logger

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
      {:hello_reply, pid, who} -> send(pid, hello(who))
      {:compute_reply, pid, s} -> send(pid, compute(s))
      x -> Logger.debug(inspect(x))
    after
      5000 ->
        Logger.debug("Timeout after 5 seconds")
        :ok
    end

    infinite_receive_loop()
  end
end
