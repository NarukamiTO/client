package alternativa.tanks.model.payment {
  import alternativa.startup.StartupSettings;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.net.URLVariables;
  import projects.tanks.client.panel.model.payment.modes.PaymentRequestVariable;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class PaymentUtils {
    public function PaymentUtils() {
      super();
    }

    public static function createUrlRequest(param1:PaymentRequestUrl) : URLRequest {
      var local5:URLVariables = null;
      var local6:String = null;
      var local7:PaymentRequestVariable = null;
      var local8:String = null;
      var local9:Array = null;
      var local2:Array = param1.host.split("?");
      var local3:String = local2[0];
      var local4:URLRequest = new URLRequest(local3);
      if(param1.encodeParameters) {
        local5 = new URLVariables();
        local6 = local2[1];
        if(local6 != null) {
          for each(local8 in local6.split("&")) {
            local9 = local8.split("=");
            local5[local9[0]] = local9[1];
          }
        }
        for each(local7 in param1.parameters) {
          local5[local7.variable] = local7.value;
        }
        local4.data = local5;
      } else {
        local4.data = local2[1];
      }
      local4.method = getRequestMethod(param1);
      return local4;
    }

    public static function createOrderedUrlRequest(param1:PaymentRequestUrl) : URLRequest {
      var local2:Array = param1.host.split("?");
      var local3:String = local2[0];
      var local4:Vector.<PaymentRequestVariable> = new Vector.<PaymentRequestVariable>();
      local4 = local4.concat(getParamsFromHostString(local2[1]));
      local4 = local4.concat(param1.parameters);
      var local5:URLRequest = new URLRequest();
      local5.url = local3;
      local5.data = encodeRequestParams(local4);
      local5.method = getRequestMethod(param1);
      return local5;
    }

    private static function getRequestMethod(param1:PaymentRequestUrl) : String {
      return param1.getRequest || Boolean(StartupSettings.isDesktop) ? URLRequestMethod.GET : URLRequestMethod.POST;
    }

    private static function getParamsFromHostString(param1:String) : Vector.<PaymentRequestVariable> {
      var local3:String = null;
      var local4:Array = null;
      var local2:Vector.<PaymentRequestVariable> = new Vector.<PaymentRequestVariable>();
      if(param1 != null) {
        for each(local3 in param1.split("&")) {
          local4 = local3.split("=");
          local2.push(new PaymentRequestVariable(local4[1],local4[0]));
        }
      }
      return local2;
    }

    private static function encodeRequestParams(param1:Vector.<PaymentRequestVariable>) : Object {
      var local3:PaymentRequestVariable = null;
      var local2:String = "";
      for each(local3 in param1) {
        local2 = local2 + encodeURIComponent(local3.variable) + "=" + encodeURIComponent(local3.value) + "&";
      }
      return local2.substr(0,local2.length - 1);
    }
  }
}
