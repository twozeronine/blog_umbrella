defmodule BlogClient.HttpoisonClient do
  @behaviour BlogClient.Client

  @api_url Application.compile_env(:blog_client, [BlogClient, :api_url])

  @impl true
  def get(url, headers) do
    "#{@api_url}#{url}"
    |> HTTPoison.get(headers)
    |> handle_response()
  end

  @impl true
  def post(url, req_body, headers) do
    "#{@api_url}#{url}"
    |> HTTPoison.post(req_body, headers)
    |> handle_response()
  end

  @impl true
  def update(url, req_body, headers) do
    "#{@api_url}#{url}"
    |> HTTPoison.put(req_body, headers)
    |> handle_response()
  end

  @impl true
  def delete(url) do
    "#{@api_url}#{url}"
    |> HTTPoison.delete()
    |> handle_response()
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, {:status_code, 200}, {:body, body}}

      {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        {:ok, {:status_code, 200}, {:body, body}}

      {:ok, %HTTPoison.Response{status_code: 204, body: body}} ->
        {:ok, {:status_code, 200}, {:body, body}}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, {:status_code, 404}, :not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
