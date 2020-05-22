defmodule EDA.Service do
  use GenServer

  require Logger

  @spec start_link(arg :: any) :: {:ok, pid}
  def start_link(args \\ []) do
    Logger.debug("#{__MODULE__}.start_link(#{inspect(args)})")
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  @spec init(any) :: {:ok, initial_state :: any()}
  def init(args) do
    Logger.info("#{__MODULE__}.init(#{inspect(args)})")
    {:ok, 0}
  end

  @impl true
  def handle_cast({:compute, password}, count) do
    Logger.debug("handle_cast({:compute, #{password}, #{count})")
    EDA.compute(password)
    {:noreply, count + 1}
  end

  @impl true
  def handle_call({:compute, password}, from, count) do
    Logger.debug("handle_call({:compute, #{password}}, #{inspect(from)}, #{count})")
    hash = EDA.compute(password)
    {:reply, hash, count + 1}
  end
end
