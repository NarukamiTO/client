package alternativa.tanks.models.panel.create {
  import flash.events.Event;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class CreateClanServiceEvent extends Event {
    public static const CREATE:String = "CreateClanServiceEvent.CREATE";
    public static const VALIDATE_NAME:String = "CreateClanServiceEvent.VALIDATE_NAME";
    public static const VALIDATE_TAG:String = "CreateClanServiceEvent.VALIDATE_TAG";
    public static const CORRECT_NAME:String = "ValidateClanNameEvent.CORRECT_NAME";
    public static const INCORRECT_NAME:String = "ValidateClanNameEvent.INCORRECT_NAME";
    public static const CORRECT_TAG:String = "ValidateClanNameEvent.CORRECT_TAG";
    public static const INCORRECT_TAG:String = "ValidateClanNameEvent.INCORRECT_TAG";
    public static const NOT_UNIQUE_NAME:String = "ValidateClanNameEvent.NOT_UNIQUE_NAME";
    public static const NOT_UNIQUE_TAG:String = "ValidateClanNameEvent.NOT_UNIQUE_TAG";
    public static const OTHER_ERROR:String = "ValidateClanNameEvent.OTHER_ERROR";
    public static const ALREADY_IN_CLAN:String = "ValidateClanNameEvent.ALREADY_IN_CLAN";

    public var clanName:String;
    public var clanTag:String;
    public var description:String;
    public var clanFlag:ClanFlag;

    public function CreateClanServiceEvent(param1:String, param2:String = "", param3:String = "", param4:String = "", param5:ClanFlag = null, param6:Boolean = false, param7:Boolean = false) {
      this.clanName = param2;
      this.clanTag = param3;
      this.description = param4;
      this.clanFlag = param5;
      super(param1,param6,param7);
    }
  }
}
