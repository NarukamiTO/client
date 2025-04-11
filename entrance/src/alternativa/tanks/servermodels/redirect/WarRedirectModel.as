package alternativa.tanks.servermodels.redirect {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import projects.tanks.client.entrance.model.entrance.redirect.IWarRedirectModelBase;
  import projects.tanks.client.entrance.model.entrance.redirect.WarRedirectModelBase;

  [ModelInfo]
  public class WarRedirectModel extends WarRedirectModelBase implements IWarRedirectModelBase {
    public function WarRedirectModel() {
      super();
    }

    public function receiveUrl(param1:String) : void {
      navigateToURL(new URLRequest(param1),"_self");
    }
  }
}
