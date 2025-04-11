package projects.tanks.client.panel.model.premiumaccount.alert {
  public class PremiumAccountAlertCC {
    private var _localRuntimeUser:Boolean;
    private var _needShowNotificationCompletionPremium:Boolean;
    private var _needShowWelcomeAlert:Boolean;
    private var _reminderCompletionPremiumTime:Number;
    private var _wasShowAlertForFirstPurchasePremium:Boolean;
    private var _wasShowReminderCompletionPremium:Boolean;

    public function PremiumAccountAlertCC(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Number = 0, param5:Boolean = false, param6:Boolean = false) {
      super();
      this._localRuntimeUser = param1;
      this._needShowNotificationCompletionPremium = param2;
      this._needShowWelcomeAlert = param3;
      this._reminderCompletionPremiumTime = param4;
      this._wasShowAlertForFirstPurchasePremium = param5;
      this._wasShowReminderCompletionPremium = param6;
    }

    public function get localRuntimeUser() : Boolean {
      return this._localRuntimeUser;
    }

    public function set localRuntimeUser(param1:Boolean) : void {
      this._localRuntimeUser = param1;
    }

    public function get needShowNotificationCompletionPremium() : Boolean {
      return this._needShowNotificationCompletionPremium;
    }

    public function set needShowNotificationCompletionPremium(param1:Boolean) : void {
      this._needShowNotificationCompletionPremium = param1;
    }

    public function get needShowWelcomeAlert() : Boolean {
      return this._needShowWelcomeAlert;
    }

    public function set needShowWelcomeAlert(param1:Boolean) : void {
      this._needShowWelcomeAlert = param1;
    }

    public function get reminderCompletionPremiumTime() : Number {
      return this._reminderCompletionPremiumTime;
    }

    public function set reminderCompletionPremiumTime(param1:Number) : void {
      this._reminderCompletionPremiumTime = param1;
    }

    public function get wasShowAlertForFirstPurchasePremium() : Boolean {
      return this._wasShowAlertForFirstPurchasePremium;
    }

    public function set wasShowAlertForFirstPurchasePremium(param1:Boolean) : void {
      this._wasShowAlertForFirstPurchasePremium = param1;
    }

    public function get wasShowReminderCompletionPremium() : Boolean {
      return this._wasShowReminderCompletionPremium;
    }

    public function set wasShowReminderCompletionPremium(param1:Boolean) : void {
      this._wasShowReminderCompletionPremium = param1;
    }

    public function toString() : String {
      var local1:String = "PremiumAccountAlertCC [";
      local1 += "localRuntimeUser = " + this.localRuntimeUser + " ";
      local1 += "needShowNotificationCompletionPremium = " + this.needShowNotificationCompletionPremium + " ";
      local1 += "needShowWelcomeAlert = " + this.needShowWelcomeAlert + " ";
      local1 += "reminderCompletionPremiumTime = " + this.reminderCompletionPremiumTime + " ";
      local1 += "wasShowAlertForFirstPurchasePremium = " + this.wasShowAlertForFirstPurchasePremium + " ";
      local1 += "wasShowReminderCompletionPremium = " + this.wasShowReminderCompletionPremium + " ";
      return local1 + "]";
    }
  }
}
