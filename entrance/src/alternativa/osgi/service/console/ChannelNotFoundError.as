package alternativa.osgi.service.console {
  public class ChannelNotFoundError extends Error {
    public function ChannelNotFoundError(param1:String) {
      super("Channel not found " + param1);
    }
  }
}
