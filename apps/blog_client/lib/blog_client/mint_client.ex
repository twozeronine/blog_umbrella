defmodule BlogClient.MintClient do
  @behaviour BlogClient.Client
  @port Application.compile_env(:blog_client, [BlogClient, :port])
  @host Application.compile_env(:blog_client, [BlogClient, :host])

  @impl true
  def get(url, headers) do
    {:ok, conn} = connect()
    http_request(conn, "GET", url, headers, "")
  end

  @impl true
  def post(url, req_body, headers) do
    {:ok, conn} = connect()
    http_request(conn, "POST", url, headers, req_body)
  end

  @impl true
  def update(url, req_body, headers) do
    {:ok, conn} = connect()
    http_request(conn, "PUT", url, headers, req_body)
  end

  @impl true
  def delete(url) do
    {:ok, conn} = connect()
    http_request(conn, "DELETE", url, [], "")
  end

  defp connect() do
    {:ok, _conn} = Mint.HTTP.connect(:http, @host, @port, [])
  end

  defp http_request(conn, method, url, header, body) do
    {:ok, conn, request_ref} = Mint.HTTP.request(conn, method, "/api#{url}", header, body)

    receive do
      message ->
        {:ok, conn, responses} = Mint.HTTP.stream(conn, message)

        messages =
          for response <- responses do
            handle_response(response, request_ref)
          end

        Mint.HTTP.close(conn)
        {:ok, messages}
    end
  end

  defp handle_response(response, request_ref) do
    case response do
      {:status, ^request_ref, status_code} -> {:status_code, status_code}
      {:headers, ^request_ref, headers} -> {:headers, headers}
      {:data, ^request_ref, data} -> {:data, data}
      {:done, ^request_ref} -> {:done}
    end
  end
end
