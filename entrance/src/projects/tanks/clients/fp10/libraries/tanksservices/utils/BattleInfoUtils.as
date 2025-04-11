package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class BattleInfoUtils {
    [Inject]
    public static var addressService:AddressService;

    [Inject]
    public static var partnersService:IPartnerService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const BATTLE_NAME_SEPARATOR:String = " ";

    public function BattleInfoUtils() {
      super();
    }

    public static function getBattleBaseUrl() : String {
      var local1:String = "";
      if(!partnersService.isRunningInsidePartnerEnvironment()) {
        local1 = addressService.getBaseURL();
      }
      return local1;
    }

    public static function getBattleIdUhex(param1:Long) : String {
      return intToUhex(param1.high) + intToUhex(param1.low);
    }

    private static function intToUhex(param1:int) : String {
      var local2:String = null;
      var local4:uint = 0;
      if(param1 >= 0) {
        local2 = param1.toString(16);
      } else {
        local4 = uint(param1 & ~2147483648 | 2147483648);
        local2 = local4.toString(16);
      }
      var local3:int = 8 - local2.length;
      while(local3 > 0) {
        local2 = "0" + local2;
        local3--;
      }
      return local2;
    }

    public static function buildBattleName(param1:String, param2:String) : String {
      return param1 + BATTLE_NAME_SEPARATOR + getShortBattleModeName(param2);
    }

    private static function getShortBattleModeName(param1:String) : String {
      switch(param1) {
        case BattleMode.DM.name:
          return localeService.getText(TanksLocale.TEXT_DM_SHORT_NAME);
        case BattleMode.TDM.name:
          return localeService.getText(TanksLocale.TEXT_TDM_SHORT_NAME);
        case BattleMode.CTF.name:
          return localeService.getText(TanksLocale.TEXT_CTF_SHORT_NAME);
        case BattleMode.CP.name:
          return localeService.getText(TanksLocale.TEXT_CP_SHORT_NAME);
        case BattleMode.AS.name:
          return localeService.getText(TanksLocale.TEXT_AS_SHORT_NAME);
        case BattleMode.RUGBY.name:
          return localeService.getText(TanksLocale.TEXT_RUGBY_SHORT_NAME);
        case BattleMode.JGR.name:
          return localeService.getText(TanksLocale.TEXT_JGR_SHORT_NAME);
        default:
          return null;
      }
    }
  }
}
