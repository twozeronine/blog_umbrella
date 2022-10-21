defmodule BlogClient.HttpoisonClient do
  @behaviour BlogClient.Client

  @api_url Application.compile_env(:blog_client, [BlogClient, :api_url])

  @impl true
  def get(url) do
    "#{@api_url}/#{url}"
    |> HTTPoison.get()
  end

  @impl true
  def post(url, req_body, header) do
    "#{@api_url}/#{url}"
    |> HTTPoison.post(req_body, [header])
  end

  @impl true
  def update(url, req_body, header) do
    "#{@api_url}/#{url}"
    |> HTTPoison.put(req_body, [header])
  end

  @impl true
  def delete(url) do
    "#{@api_url}/#{url}"
    |> HTTPoison.delete()
  end
end
