package alternativa.tanks.servermodels {
  import alternativa.osgi.service.clientlog.IClientLog;
  import flash.net.URLRequest;
  import flash.net.sendToURL;
  import projects.tanks.client.entrance.model.entrance.trackingshower.ITrackingPixelShowingModelBase;
  import projects.tanks.client.entrance.model.entrance.trackingshower.TrackingPixelShowingModelBase;

  [ModelInfo]
  public class TrackingPixelShowing extends TrackingPixelShowingModelBase implements ITrackingPixelShowingModelBase {
    [Inject]
    public static var clientLog:IClientLog;

    public function TrackingPixelShowing() {
      super();
    }

    public function loadPixel(param1:String) : void {
      sendToURL(new URLRequest(param1));
    }
  }
}
