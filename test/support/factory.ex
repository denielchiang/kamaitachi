defmodule Kamaitachi.Factory do
  @mux_live_stream_status %{
    created: :mux_video_live_stream_created,
    connected: :mux_video_live_stream_connected,
    recording: :mux_video_live_stream_recording,
    active: :mux_video_live_stream_active,
    disconnected: :mux_video_live_stream_disconnected,
    idle: :mux_video_live_stream_idle,
    updated: :mux_video_live_stream_updated,
    enabled: :mux_video_live_stream_enabled,
    disabled: :mux_video_live_stream_disabled,
    deleted: :mux_video_live_stream_deleted
  }

  def mux_status(key), do: Map.get(@mux_live_stream_status, key)

  def build(:mux_video_live_stream_created), do: mux_video_live_stream_created()
  def bulld(:mux_video_live_stream_connected), do: mux_video_live_stream_connected()
  def build(:mux_video_live_stream_recording), do: mux_video_live_stream_recording()
  def bulld(:mux_video_live_stream_active), do: mux_video_live_stream_active()
  def build(:mux_video_live_stream_disconnected), do: mux_video_live_stream_disconnected()
  def bulld(:mux_video_live_stream_idle), do: mux_video_live_stream_idle()
  def build(:mux_video_live_stream_updated), do: mux_video_live_stream_updated()
  def bulld(:mux_video_live_stream_enabled), do: mux_video_live_stream_enabled()
  def build(:mux_video_live_stream_disabled), do: mux_video_live_stream_disabled()
  def bulld(:mux_video_live_stream_deleted), do: mux_video_live_stream_deleted()

  def build(factory_name) do
    factory_name |> build()
  end

  defp mux_video_live_stream_created do
    %{get_base_json() | "type" => "video.live_stream.created"}
  end

  defp mux_video_live_stream_connected do
    %{get_base_json() | "type" => "video.live_stream.created"}
  end

  defp mux_video_live_stream_recording do
    %{get_base_json() | "type" => "video.live_stream.recording"}
  end

  defp mux_video_live_stream_active do
    %{get_base_json() | "type" => "video.live_stream.active"}
  end

  defp mux_video_live_stream_disconnected do
    %{get_base_json() | "type" => "video.live_stream.disconnected"}
  end

  defp mux_video_live_stream_idle do
    %{get_base_json() | "type" => "video.live_stream.idle"}
  end

  defp mux_video_live_stream_updated do
    %{get_base_json() | "type" => "video.live_stream.updated"}
  end

  defp mux_video_live_stream_enabled do
    %{get_base_json() | "type" => "video.live_stream.enabled"}
  end

  defp mux_video_live_stream_disabled do
    %{get_base_json() | "type" => "video.live_stream.disabled"}
  end

  defp mux_video_live_stream_deleted do
    %{get_base_json() | "type" => "video.live_stream.deleted"}
  end

  defp get_base_json do
    %{
      "accessor" => nil,
      "accessor_source" => nil,
      "attempts" => [],
      "created_at" => "2021-03-14T11:29:39.000000Z",
      "data" => %{
        "created_at" => 1_615_721_379,
        "id" => "6Or7Z2tb1veXwesdmITWyMAdvW8hH6XX83Ufgrl2u7Y",
        "new_asset_settings" => %{"playback_policies" => ["public"]},
        "playback_ids" => [
          %{"id" => "3KOcx7PeWw3YzXQSTUwGmwz9TBcB8FVJH73qpNP00h02o", "policy" => "public"}
        ],
        "reconnect_window" => 60,
        "status" => "idle",
        "stream_key" => "fe1ea942-63d6-b254-05bc-2b545afecf2c",
        "test" => true
      },
      "environment" => %{"id" => "loiari", "name" => "Development"},
      "id" => "1afa69f0-b2a8-4650-b666-0ac58e7db0f7",
      "object" => %{"id" => "6Or7Z2tb1veXwesdmITWyMAdvW8hH6XX83Ufgrl2u7Y", "type" => "live"},
      "request_id" => nil,
      "type" => nil
    }
  end
end
