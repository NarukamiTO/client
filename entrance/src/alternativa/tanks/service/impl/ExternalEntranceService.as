package alternativa.tanks.service.impl {
  import alternativa.startup.StartupSettings;
  import alternativa.tanks.service.IExternalEntranceService;
  import flash.system.Capabilities;
  import flash.utils.Dictionary;

  public class ExternalEntranceService implements IExternalEntranceService {
    public static const VKONTAKTE:String = "vkontakte";
    public static const FACEBOOK:String = "facebook";
    public static const GOOGLE:String = "google";

    private var _snEnabled:Dictionary = new Dictionary();

    public function ExternalEntranceService() {
      super();
    }

    public function get vkontakteEnabled() : Boolean {
      if(Boolean(this._snEnabled[VKONTAKTE])) {
        return this._snEnabled[VKONTAKTE];
      }
      return false;
    }

    public function get facebookEnabled() : Boolean {
      if(Boolean(this._snEnabled[FACEBOOK])) {
        return this._snEnabled[FACEBOOK];
      }
      return false;
    }

    public function get googleEnabled() : Boolean {
      if(Boolean(this._snEnabled[GOOGLE])) {
        return Boolean(this._snEnabled[GOOGLE]) && !StartupSettings.isDesktop && Capabilities.playerType != "StandAlone";
      }
      return false;
    }

    public function setEnabled(param1:String, param2:Boolean) : void {
      this._snEnabled[param1] = param2;
    }
  }
}
