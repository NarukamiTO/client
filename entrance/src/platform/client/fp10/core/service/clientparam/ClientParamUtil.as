package platform.client.fp10.core.service.clientparam {
  import flash.external.ExternalInterface;
  import flash.system.Capabilities;
  import flash.utils.Dictionary;

  public class ClientParamUtil {
    public function ClientParamUtil() {
      super();
    }

    public static function collectClientParams() : Dictionary {
      var local1:Dictionary = new Dictionary();
      var local2:Array = Capabilities.version.split(" ");
      if(local2.length === 2) {
        local1[ClientParamEnum.OS] = local2[0];
        local1[ClientParamEnum.FLASH_PLAYER_VERSION] = local2[1];
      }
      local1[ClientParamEnum.FLASH_PLAYER_TYPE] = Capabilities.playerType;
      if(ExternalInterface.available) {
        local1[ClientParamEnum.BROWSER_USER_AGENT] = ExternalInterface.call("window.navigator.userAgent.toString").replace(/;/gi,",");
      }
      // Narukami baseline - send information about client and supported extensions
      local1[ClientParamEnum.IDENTITY] = BuildConfig.IDENTITY.join(",");
      return local1;
    }
  }
}
