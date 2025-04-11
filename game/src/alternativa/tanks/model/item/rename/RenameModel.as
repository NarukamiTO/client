package alternativa.tanks.model.item.rename {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.item.actionpanel.SingleActionPanel;
  import alternativa.tanks.model.item.countable.ICountableItem;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import alternativa.tanks.service.garage.GarageService;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import flash.net.SharedObject;
  import mx.utils.StringUtil;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.garage.prototypes.item.renameitem.IRenameModelBase;
  import projects.tanks.client.garage.prototypes.item.renameitem.RenameModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class RenameModel extends RenameModelBase implements IRenameModelBase, ItemActionPanel, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var garageService:GarageService;

    private var renameForm:RenameForm;

    public function RenameModel() {
      super();
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      SingleActionPanel(getData(SingleActionPanel)).updateActionElements(param1);
    }

    public function handleDoubleClickOnItemPreview() : void {
      if(!this.renameForm) {
        this.renameForm = new RenameForm(!partnerService.isRunningInsidePartnerEnvironment());
        this.renameForm.addEventListener(RenameEvent.RENAME_EVENT,getFunctionWrapper(this.onRename));
      }
      this.renameForm.show();
    }

    private function onRename(param1:RenameEvent) : void {
      server.rename(param1.getNickname());
      this.renameForm.close();
    }

    public function objectLoaded() : void {
      var local1:SingleActionPanel = new SingleActionPanel(localeService.getText(TanksLocale.TEXT_RENAME_BUTTON_LABEL_IN_GARAGE),getFunctionWrapper(this.handleDoubleClickOnItemPreview));
      putData(SingleActionPanel,local1);
    }

    public function objectUnloaded() : void {
      if(Boolean(this.renameForm)) {
        this.renameForm.removeEventListener(RenameEvent.RENAME_EVENT,getFunctionWrapper(this.onRename));
        this.renameForm.dispose();
        this.renameForm = null;
      }
    }

    public function renameFail() : void {
      alertService.showOkAlert(localeService.getText(TanksLocale.TEXT_RENAME_FAILED_ALERT));
    }

    public function renameSuccessfull(param1:String, param2:String) : void {
      this.renameInCommonShared(param1,param2);
      this.renameInAccountShared(param1,param2);
      if(ICountableItem(object.adapt(ICountableItem)).getCount() <= 1) {
        garageService.getView().removeItemFromDepot(object);
      }
    }

    private function renameInCommonShared(param1:String, param2:String) : void {
      var local3:SharedObject = storageService.getStorage();
      var local4:String = StringUtil.trim(local3.data.userName);
      if(local4.length != 0 && local4 == param1) {
        local3.data.userName = param2;
        local3.flush();
      }
    }

    private function renameInAccountShared(param1:String, param2:String) : void {
      var local3:SharedObject = storageService.getAccountsStorage();
      var local4:Object = local3.data[param1];
      if(Boolean(local4)) {
        local3.data[param2] = local3.data[param1];
        local3.data[param2].userName = param2;
        delete local3.data[param1];
        local3.flush();
      }
    }
  }
}
