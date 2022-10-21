defmodule BlogClient.Client do
  @callback get(url :: String.t()) :: Tuple.t()
  @callback post(url :: String.t(), req_body :: String.t()) :: Tuple.t()
  @callback update(url :: String.t(), req_body :: String.t()) :: Tuple.t()
  @callback delete(url :: String.t()) :: Tuple.t()
end
