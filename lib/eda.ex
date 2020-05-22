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
end
