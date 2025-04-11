package projects.tanks.clients.flash.commons.services.externalauth {
  import flash.utils.Dictionary;

  public class ExternalAuthParamsServiceImpl implements ExternalAuthParamsService {
    private static const params:* = new Dictionary();

    public function ExternalAuthParamsServiceImpl() {
      super();
    }

    public function setParam(param1:String, param2:String) : * {
      params[param1] = param2;
    }
  }
}
