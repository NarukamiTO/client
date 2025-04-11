package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.odnoklassniki {
  import projects.tanks.client.partners.impl.odnoklassniki.OdnoklassnikiUrlParams;

  public class ParamHelper {
    public function ParamHelper() {
      super();
    }

    public static function name(param1:OdnoklassnikiUrlParams) : String {
      return param1.name.toLocaleLowerCase();
    }
  }
}
