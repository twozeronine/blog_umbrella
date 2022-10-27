defmodule BlogClient.Client do
  @typep url :: binary
  @typep headers :: list()
  @typep req_body :: binary()

  @callback get(url, headers) :: Tuple.t()
  @callback post(url, req_body, headers) :: Tuple.t()
  @callback update(url, req_body, headers) :: Tuple.t()
  @callback delete(url) :: Tuple.t()
end
