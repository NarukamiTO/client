package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.buttons.GarageButton;
  import alternativa.tanks.gui.buttons.TimerButton;
  import alternativa.tanks.gui.buttons.TimerButtonEvent;
  import alternativa.tanks.gui.device.ItemInfoDevicesPanel;
  import alternativa.tanks.gui.effects.BlinkEffect;
  import alternativa.tanks.gui.effects.GlowEffect;
  import alternativa.tanks.gui.resistance.GarageResistancesIconsUtils;
  import alternativa.tanks.gui.tables.KitInfoTable;
  import alternativa.tanks.gui.upgrade.ItemPropertyUpgradeEvent;
  import alternativa.tanks.gui.upgrade.SelectUpgradeWindow;
  import alternativa.tanks.gui.upgrade.UpgradeButton;
  import alternativa.tanks.gui.upgrade.UpgradeColors;
  import alternativa.tanks.help.DateTimeHelper;
  import alternativa.tanks.model.item.fitting.ItemFitting;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import alternativa.tanks.model.item.kit.GarageKit;
  import alternativa.tanks.model.item.present.PresentImage;
  import alternativa.tanks.model.item.present.UserPresent;
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.model.item.resistance.view.MountedResistancesPanel;
  import alternativa.tanks.model.item.skins.AvailableSkins;
  import alternativa.tanks.model.item.temporary.ITemporaryItem;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.Money;
  import controls.NumStepper;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import controls.buttons.h50px.GreyBigButton;
  import controls.containers.VerticalStackPanel;
  import controls.timer.CountDownTimer;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
  import flash.utils.Dictionary;
  import forms.ColorConstants;
  import forms.TankWindowWithHeader;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeChildrenFrom;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
  import utils.ScrollStyleUtils;
  import utils.resource.IResourceLoadingComplete;
  import utils.resource.ResourceLoadingWrapper;

  public class ItemInfoPanel extends Sprite implements IResourceLoadingComplete {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    [Inject]
    public static var dialogService:IDialogsService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var userGarageActionsService:UserGarageActionsService;

    [Inject]
    public static var tank3dView:ITank3DViewer;

    [Inject]
    public static var deviceService:DeviceService;

    public static const INVENTORY_MAX_VALUE:int = 9999;

    private static const TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE:int = 15;
    private static const BOTTOM_MARGIN:int = 64;
    private static const BUTTON_SIZE:Point = new Point(120,50);
    private static const ICON_SPACING_H:int = 10;
    private static const HORIZONTAL_MARGIN:int = 12;
    private static const VERTICAL_MARGIN:int = 9;
    private static const MODULE_SPACING:int = 3;
    private static const KIT_INFO_TOP_MARGIN:int = 10;

    public const margin:int = 11;

    public var size:Point;
    public var inventoryNumStepper:NumStepper;
    public var buyButton:GarageButton;
    public var equipButton:TimerButton;
    public var upgradeButton:UpgradeButton;
    public var deletePresentButton:GreyBigButton;

    private var fittingButton:GreyBigButton;
    private var itemNameLabel:LabelBase;
    private var descriptionCaptionLabel:LabelBase;
    private var itemDescriptionLabel:LabelBase;
    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var itemPreview:Bitmap;
    private var itemPreviewContainer:DiscreteSprite;
    private var kitFullImage:Bitmap;
    private var presentFullImage:Bitmap;
    private var propertiesParams:Vector.<ItemPropertyParams>;
    private var scrollPane:ScrollPane;
    private var scrollContainer:VerticalStackPanel;
    private var propertiesPanel:Sprite;
    private var propertiesPanelLeft:Bitmap;
    private var propertiesPanelCenter:Bitmap;
    private var propertiesPanelRight:Bitmap;
    private var area:Shape;
    private var areaRect:Rectangle;
    private var areaRect2:Rectangle;
    private var timeIndicator:LabelBase;
    private var modTable:ModTable;
    private var kitInfoTable:KitInfoTable;
    private var kitInfoPanel:Sprite;
    private var kitInfoPanelTopLeftCorner:Bitmap;
    private var kitInfoPanelCenterTopLine:Bitmap;
    private var kitInfoPanelTopRightCorner:Bitmap;
    private var kitInfoPanelLeftLine:Bitmap;
    private var kitInfoPanelRightLine:Bitmap;
    private var kitInfoPanelLeftLineSummary:Bitmap;
    private var kitInfoPanelRightLineSummary:Bitmap;
    private var kitInfoPanelLeftLineCenterSummary:Bitmap;
    private var kitInfoPanelRightLineCenterSummary:Bitmap;
    private var kitInfoPanelCenterMiddleLine:Bitmap;
    private var kitInfoPanelCenterBottomLine:Bitmap;
    private var kitInfoPanelLeftCenterLine:Bitmap;
    private var kitInfoPanelRightCenterLine:Bitmap;
    private var kitInfoPanelBackgroundUp:Shape;
    private var kitInfoPanelBackgroundBottom:Shape;
    private var isKit:Boolean;
    private var kitItemTopPreviewDiscount:LabelBase;
    private var item:IGameObject;
    private var itemCategory:ItemCategoryEnum;
    private var itemPrice:int;
    private var isCountable:Boolean = false;
    private var maxRankIndex:int;
    private var minRankIndex:int;
    private var previewLoadingId:Long;
    private var kitLoadingId:Long;
    private var presentLoadingId:Long;
    private var selectWindow:SelectUpgradeWindow;
    private var blinkEffects:Dictionary;
    private var enabledUpgrades:Boolean;
    private var presentInfoPanel:PresentInfoPanel;
    private var actionButtonsContainer:DiscreteSprite;
    private var oldActionButtonsContainer:DiscreteSprite;
    private var divicesPanelVisible:Boolean = false;
    private var devicesPanel:ItemInfoDevicesPanel;
    private var resistPanel:MountedResistancesPanel;

    public function ItemInfoPanel(param1:Boolean, param2:int) {
      var local4:TextFormat = null;
      this.propertiesParams = new Vector.<ItemPropertyParams>();
      this.blinkEffects = new Dictionary();
      this.actionButtonsContainer = new DiscreteSprite();
      this.oldActionButtonsContainer = new DiscreteSprite();
      super();
      this.enabledUpgrades = param1;
      this.size = new Point(400,300);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_INFORMATION,this.size.x,this.size.y);
      addChild(this.window);
      this.inner = new TankWindowInner(164,106,TankWindowInner.GREEN);
      this.inner.showBlink = true;
      addChild(this.inner);
      this.inner.x = this.margin;
      this.inner.y = this.margin;
      this.area = new Shape();
      this.areaRect = new Rectangle();
      this.areaRect2 = new Rectangle(HORIZONTAL_MARGIN,VERTICAL_MARGIN,0,0);
      this.areaRect.width = param2 - this.margin * 2 - 2;
      this.areaRect2.width = this.areaRect.width - HORIZONTAL_MARGIN * 2;
      this.scrollContainer = new VerticalStackPanel();
      this.scrollContainer.x = this.margin + 1;
      this.scrollContainer.y = this.margin + 1;
      this.scrollContainer.addChild(this.area);
      this.scrollPane = new ScrollPane();
      addChild(this.scrollPane);
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.focusEnabled = false;
      this.scrollPane.x = this.margin + 1;
      this.scrollPane.y = this.margin + 1 + MODULE_SPACING;
      this.itemNameLabel = new LabelBase();
      this.itemNameLabel.text = "A";
      this.itemNameLabel.size = 18;
      this.itemNameLabel.color = ColorConstants.GREEN_TEXT;
      this.scrollContainer.addChild(this.itemNameLabel);
      this.itemNameLabel.x = HORIZONTAL_MARGIN - 3;
      this.itemNameLabel.y = VERTICAL_MARGIN - 7;
      this.devicesPanel = new ItemInfoDevicesPanel();
      this.devicesPanel.x = HORIZONTAL_MARGIN;
      this.scrollContainer.addChild(this.devicesPanel);
      this.descriptionCaptionLabel = new LabelBase();
      this.descriptionCaptionLabel.text = localeService.getText(TanksLocale.TEXT_DESCRIPTION);
      this.descriptionCaptionLabel.size = 18;
      this.descriptionCaptionLabel.color = ColorConstants.GREEN_TEXT;
      this.scrollContainer.addChild(this.descriptionCaptionLabel);
      this.descriptionCaptionLabel.x = HORIZONTAL_MARGIN - 3;
      this.itemDescriptionLabel = new LabelBase();
      var local3:String = localeService.language;
      if(local3 == "cn") {
        local4 = this.itemDescriptionLabel.getTextFormat();
        local4.leading = 3;
        this.itemDescriptionLabel.defaultTextFormat = local4;
      }
      this.itemDescriptionLabel.multiline = true;
      this.itemDescriptionLabel.wordWrap = true;
      this.itemDescriptionLabel.color = ColorConstants.GREEN_TEXT;
      this.itemDescriptionLabel.text = "Description";
      this.itemDescriptionLabel.mouseWheelEnabled = false;
      this.scrollContainer.addChild(this.itemDescriptionLabel);
      this.itemDescriptionLabel.x = HORIZONTAL_MARGIN - 3;
      this.itemPreviewContainer = new DiscreteSprite();
      this.scrollContainer.addChild(this.itemPreviewContainer);
      this.presentInfoPanel = new PresentInfoPanel(this.areaRect2.width);
      this.presentInfoPanel.x = 9;
      this.itemPreview = new Bitmap();
      this.kitFullImage = new Bitmap();
      this.presentFullImage = new Bitmap();
      this.buyButton = new GarageButton();
      this.upgradeButton = new UpgradeButton();
      this.upgradeButton.addEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
      this.equipButton = new TimerButton();
      this.equipButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
      this.fittingButton = new GreyBigButton();
      this.fittingButton.label = localeService.getText(TanksLocale.TEXT_FITTING_BUTTON_TEXT);
      this.fittingButton.visible = false;
      this.fittingButton.addEventListener(MouseEvent.CLICK,this.onFittingButtonClick);
      addChild(this.oldActionButtonsContainer);
      this.deletePresentButton = new GreyBigButton();
      this.deletePresentButton.label = localeService.getText(TanksLocale.TEXT_DELETE_PRESENT_BUTTON);
      this.deletePresentButton.visible = false;
      this.oldActionButtonsContainer.addChild(this.deletePresentButton);
      this.buyButton.visible = false;
      this.upgradeButton.visible = false;
      this.equipButton.visible = false;
      this.oldActionButtonsContainer.addChild(this.buyButton);
      this.oldActionButtonsContainer.addChild(this.upgradeButton);
      this.oldActionButtonsContainer.addChild(this.equipButton);
      this.oldActionButtonsContainer.addChild(this.fittingButton);
      addChild(this.actionButtonsContainer);
      this.inventoryNumStepper = new NumStepper();
      this.oldActionButtonsContainer.addChild(this.inventoryNumStepper);
      this.inventoryNumStepper.value = 1;
      this.inventoryNumStepper.minValue = 1;
      this.inventoryNumStepper.maxValue = INVENTORY_MAX_VALUE;
      this.inventoryNumStepper.visible = false;
      this.inventoryNumStepper.mouseEnabled = false;
      this.inventoryNumStepper.addEventListener(Event.CHANGE,this.inventoryNumChanged);
      this.propertiesPanel = new Sprite();
      this.propertiesPanelLeft = new Bitmap(ItemInfoPanelBitmaps.propertiesLeft);
      this.propertiesPanel.addChild(this.propertiesPanelLeft);
      this.propertiesPanelCenter = new Bitmap(ItemInfoPanelBitmaps.propertiesCenter);
      this.propertiesPanel.addChild(this.propertiesPanelCenter);
      this.propertiesPanelRight = new Bitmap(ItemInfoPanelBitmaps.propertiesRight);
      this.propertiesPanel.addChild(this.propertiesPanelRight);
      this.propertiesPanelCenter.x = this.propertiesPanelLeft.width;
      this.propertiesPanel.x = HORIZONTAL_MARGIN;
      this.propertiesPanel.y = Math.round(VERTICAL_MARGIN * 2 + this.itemNameLabel.textHeight - 7);
      this.getResistPanel().visible = false;
      addChild(this.getResistPanel());
      this.addKitInfoPanel();
      addEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED,this.openUpgradeWindow);
      this.timeIndicator = new LabelBase();
      this.timeIndicator.size = 18;
      this.timeIndicator.color = ColorConstants.GREEN_TEXT;
      this.modTable = new ModTable(this.areaRect2.width);
      this.modTable.x = HORIZONTAL_MARGIN;
      this.kitItemTopPreviewDiscount = new LabelBase();
      this.kitItemTopPreviewDiscount.color = 16777215;
      this.kitItemTopPreviewDiscount.align = TextFormatAlign.CENTER;
      this.kitItemTopPreviewDiscount.size = 23;
      this.kitItemTopPreviewDiscount.bold = true;
      if(local3 == "cn") {
        this.kitItemTopPreviewDiscount.size = 20;
      }
    }

    public static function getRequiredRank(param1:int, param2:int) : int {
      var local3:int = int(userPropertiesService.rank);
      var local4:int = param1;
      if(local3 < param1) {
        local4 = -param1;
      } else if(local3 > param2) {
        local4 = -param2;
      }
      return local4;
    }

    public function getResistPanel() : MountedResistancesPanel {
      if(this.resistPanel == null) {
        this.resistPanel = new MountedResistancesPanel();
        this.resistPanel.visible = false;
      }
      return this.resistPanel;
    }

    private function addKitInfoPanel() : void {
      this.kitInfoPanel = new Sprite();
      this.kitInfoPanelTopLeftCorner = new Bitmap(ItemInfoPanelBitmaps.leftTopCornerTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelTopLeftCorner);
      this.kitInfoPanelCenterTopLine = new Bitmap(ItemInfoPanelBitmaps.centerTopTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelCenterTopLine);
      this.kitInfoPanelTopRightCorner = new Bitmap(ItemInfoPanelBitmaps.rightTopCornerTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelTopRightCorner);
      this.kitInfoPanelCenterTopLine.x = this.kitInfoPanelTopLeftCorner.width;
      this.kitInfoPanelLeftLine = new Bitmap(ItemInfoPanelBitmaps.leftLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelLeftLine);
      this.kitInfoPanelRightLine = new Bitmap(ItemInfoPanelBitmaps.rightLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelRightLine);
      this.kitInfoPanelLeftCenterLine = new Bitmap(ItemInfoPanelBitmaps.leftCenterTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelLeftCenterLine);
      this.kitInfoPanelRightCenterLine = new Bitmap(ItemInfoPanelBitmaps.rightCenterTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelRightCenterLine);
      this.kitInfoPanelCenterMiddleLine = new Bitmap(ItemInfoPanelBitmaps.centerTopTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelCenterMiddleLine);
      this.kitInfoPanelLeftLineSummary = new Bitmap(ItemInfoPanelBitmaps.leftBottomLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelLeftLineSummary);
      this.kitInfoPanelRightLineSummary = new Bitmap(ItemInfoPanelBitmaps.rightBottomLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelRightLineSummary);
      this.kitInfoPanelCenterBottomLine = new Bitmap(ItemInfoPanelBitmaps.centerBottomLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelCenterBottomLine);
      this.kitInfoPanelLeftLineCenterSummary = new Bitmap(ItemInfoPanelBitmaps.leftLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelLeftLineCenterSummary);
      this.kitInfoPanelRightLineCenterSummary = new Bitmap(ItemInfoPanelBitmaps.rightLineTableKit);
      this.kitInfoPanel.addChild(this.kitInfoPanelRightLineCenterSummary);
      this.kitInfoPanelBackgroundUp = new Shape();
      this.kitInfoPanel.addChild(this.kitInfoPanelBackgroundUp);
      this.kitInfoPanelBackgroundBottom = new Shape();
      this.kitInfoPanel.addChild(this.kitInfoPanelBackgroundBottom);
      this.kitInfoPanel.x = HORIZONTAL_MARGIN;
      this.kitInfoTable = new KitInfoTable(this.areaRect2.width);
      this.kitInfoTable.x = HORIZONTAL_MARGIN;
    }

    public function destroy() : void {
      this.window = null;
      this.inner = null;
      this.itemPreviewContainer = null;
      this.itemPreview = null;
      this.kitFullImage = null;
      this.presentFullImage = null;
      this.item = null;
      this.itemNameLabel = null;
      this.itemDescriptionLabel = null;
      if(this.resistPanel != null) {
        this.resistPanel.destroy();
        this.resistPanel = null;
      }
      this.scrollPane = null;
      this.scrollContainer = null;
      this.propertiesPanel = null;
      this.propertiesPanelLeft = null;
      this.propertiesPanelCenter = null;
      this.propertiesPanelRight = null;
      this.kitInfoPanel = null;
      this.kitInfoPanelTopLeftCorner = null;
      this.kitInfoPanelCenterTopLine = null;
      this.kitInfoPanelTopRightCorner = null;
      this.kitInfoPanelLeftLine = null;
      this.area = null;
      this.areaRect = null;
      this.areaRect2 = null;
      this.oldActionButtonsContainer = null;
      this.buyButton = null;
      this.fittingButton.removeEventListener(MouseEvent.CLICK,this.onFittingButtonClick);
      this.fittingButton = null;
      if(this.equipButton != null) {
        this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
        this.equipButton.hideTime();
        this.equipButton = null;
      }
      if(this.upgradeButton != null) {
        this.upgradeButton.removeEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
        this.upgradeButton = null;
      }
      removeEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED,this.openUpgradeWindow);
      if(this.devicesPanel != null) {
        this.devicesPanel.destroy();
        this.devicesPanel = null;
      }
      this.previewLoadingId = null;
      this.stopBlinkEffects();
      this.blinkEffects = null;
      if(Boolean(this.selectWindow)) {
        this.selectWindow.destroy();
        this.selectWindow = null;
      }
      this.presentInfoPanel.destroy();
      this.presentInfoPanel = null;
      this.actionButtonsContainer = null;
    }

    private function onFittingButtonClick(param1:MouseEvent) : void {
      ItemFitting(this.item.adapt(ItemFitting)).fit();
      this.fittingButton.enabled = false;
    }

    private function stopBlinkEffects() : void {
      var local1:BlinkEffect = null;
      for each(local1 in this.blinkEffects) {
        local1.stop();
      }
    }

    private function hideIcons() : void {
      var local1:ItemPropertyParams = null;
      for each(local1 in this.propertiesParams) {
        if(this.propertiesPanel.contains(local1.icon)) {
          this.propertiesPanel.removeChild(local1.icon);
        }
      }
    }

    private function showIcons() : void {
      var local1:ItemPropertyParams = null;
      for each(local1 in this.propertiesParams) {
        if(!this.propertiesPanel.contains(local1.icon)) {
          this.propertiesPanel.addChild(local1.icon);
        }
      }
    }

    public function onLoadingComplete(param1:Resource) : void {
      if(this.previewLoadingId == param1.id) {
        if(!this.isKit && !itemService.isGivenPresent(this.item)) {
          this.itemPreview.bitmapData = ImageResource(param1).data;
          this.resize(this.size.x,this.size.y);
        }
      }
      if(this.kitLoadingId == param1.id) {
        if(this.isKit) {
          this.kitFullImage.bitmapData = ImageResource(param1).data;
          this.showBitmap(this.kitFullImage);
          this.resize(this.size.x,this.size.y);
        }
      }
      if(this.presentLoadingId == param1.id) {
        if(itemService.isGivenPresent(this.item)) {
          this.presentFullImage.bitmapData = ImageResource(param1).data;
          this.showBitmap(this.presentFullImage);
          this.resize(this.size.x,this.size.y);
        }
      }
    }

    public function showItemInfo(param1:IGameObject, param2:Boolean) : void {
      var local4:UserPresent = null;
      this.itemCategory = itemService.getCategory(param1);
      this.itemPrice = itemService.getPrice(param1);
      this.isCountable = itemService.isCountable(param1);
      this.divicesPanelVisible = param1.hasModel(AvailableSkins);
      if(this.divicesPanelVisible) {
        this.devicesPanel.init(param1);
      }
      if(!param2 && !itemService.isGivenPresent(param1)) {
        this.updateUpgradeButton(param1);
      }
      removeChildrenFrom(this.itemPreviewContainer);
      removeChildrenFrom(this.actionButtonsContainer);
      this.updateFittingButton(param2,this.item,param1);
      if(this.item != param1) {
        tank3dView.closePreview();
        this.item = param1;
      }
      this.itemNameLabel.text = itemService.getName(param1);
      this.itemDescriptionLabel.visible = !itemService.isGivenPresent(param1);
      this.descriptionCaptionLabel.visible = this.divicesPanelVisible && Boolean(this.itemDescriptionLabel.visible);
      if(this.itemDescriptionLabel.visible) {
        this.itemDescriptionLabel.htmlText = itemService.getDescription(param1);
      }
      this.loadAndSetupImageResources(param1);
      this.maxRankIndex = itemService.getMaxRankIndex(param1);
      this.minRankIndex = itemService.getMinRankIndex(param1);
      this.hideIcons();
      if(itemService.isGivenPresent(param1)) {
        local4 = UserPresent(param1.adapt(UserPresent));
        this.presentInfoPanel.update(local4.getPresenterId(),local4.getDate(),local4.getText());
        this.itemPreviewContainer.addChild(this.presentInfoPanel);
      } else {
        this.presentInfoPanel.destroyPresenterLabel();
      }
      if(itemService.isKit(param1)) {
        this.isKit = true;
        this.showKitInfoTable(param1);
      } else {
        this.isKit = false;
        this.hideKitInfoTable();
        if(this.scrollContainer.contains(this.kitItemTopPreviewDiscount)) {
          this.scrollContainer.removeChild(this.kitItemTopPreviewDiscount);
        }
      }
      var local3:Vector.<IGameObject> = !!itemService.isModificationItem(param1) ? itemService.getModifications(param1) : null;
      this.showItemProperties(param1,param2,local3);
      this.setButtonsVisibility(param1,param2,local3);
      this.updateStepperAndBuyButton(param1,param2);
      this.updateBlinkEffect();
      this.setButtonsPosition();
      this.updateEquipButton();
      this.setupRemainingTimer(param1,param2);
      if(!(this.oldActionButtonsContainer.visible = !param1.hasModel(ItemActionPanel))) {
        ItemActionPanel(param1.event(ItemActionPanel)).updateActionElements(this.actionButtonsContainer,this);
      }
    }

    private function showEquippedPanel(param1:TankWindowInner) : Number {
      var local2:MountedResistancesPanel = this.getResistPanel();
      local2.visible = this.itemCategory == ItemCategoryEnum.RESISTANCE_MODULE;
      if(local2.visible) {
        param1.height -= local2.height + VERTICAL_MARGIN / 2;
        local2.resize(param1.width);
      }
      return param1.height;
    }

    private function loadAndSetupImageResources(param1:IGameObject) : void {
      var local2:ImageResource = null;
      var local3:ImageResource = null;
      var local4:ImageResource = null;
      this.kitFullImage.bitmapData = null;
      this.presentFullImage.bitmapData = null;
      this.itemPreview.bitmapData = null;
      if(itemService.isKit(param1)) {
        local2 = GarageKit(param1.adapt(GarageKit)).getImage();
        this.kitLoadingId = local2.id;
        if(Boolean(local2.isLazy) && !local2.isLoaded) {
          local2.loadLazyResource(new ResourceLoadingWrapper(this));
        }
        this.kitFullImage.bitmapData = local2.data;
        if(this.kitFullImage.bitmapData != null) {
          this.showBitmap(this.kitFullImage);
        } else {
          removeDisplayObject(this.kitFullImage);
        }
      } else if(itemService.isGivenPresent(param1)) {
        local3 = PresentImage(param1.adapt(PresentImage)).getImage();
        this.presentLoadingId = local3.id;
        if(Boolean(local3.isLazy) && !local3.isLoaded) {
          local3.loadLazyResource(new ResourceLoadingWrapper(this));
        }
        this.presentFullImage.bitmapData = local3.data;
        if(this.presentFullImage.bitmapData != null) {
          this.showBitmap(this.presentFullImage);
        } else {
          removeDisplayObject(this.presentFullImage);
        }
      } else {
        local4 = itemService.getPreviewResource(param1);
        this.previewLoadingId = local4.id;
        if(Boolean(local4.isLazy) && !local4.isLoaded) {
          local4.loadLazyResource(new ResourceLoadingWrapper(this));
        }
        this.itemPreview.bitmapData = local4.data;
      }
    }

    private function setupRemainingTimer(param1:IGameObject, param2:Boolean) : void {
      if(!param2 && Boolean(param1.hasModel(ITemporaryItem))) {
        if(!this.scrollContainer.contains(this.timeIndicator)) {
          this.scrollContainer.addChild(this.timeIndicator);
        }
        this.setTimeRemaining(param1);
      } else if(this.scrollContainer.contains(this.timeIndicator)) {
        this.scrollContainer.removeChild(this.timeIndicator);
      }
    }

    private function updateStepperAndBuyButton(param1:IGameObject, param2:Boolean) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local6:int = 0;
      var local7:IGameObject = null;
      var local8:int = 0;
      if(this.buyButton.visible) {
        local3 = getRequiredRank(itemService.getMinRankIndex(param1),itemService.getMaxRankIndex(param1));
        local4 = 1;
        if(this.isCountable) {
          this.inventoryNumStepper.visible = true;
          local6 = Math.min(INVENTORY_MAX_VALUE,Math.floor(moneyService.crystal / this.itemPrice));
          if(local3 > 0) {
            if(local6 > 0) {
              this.inventoryNumStepper.enabled = true;
              this.inventoryNumStepper.alpha = 1;
            } else {
              this.inventoryNumStepper.enabled = false;
              this.inventoryNumStepper.alpha = 0.7;
            }
          } else {
            this.inventoryNumStepper.enabled = false;
            this.inventoryNumStepper.alpha = 0.7;
            this.inventoryNumStepper.value = 1;
          }
          local5 = int(itemService.getPrice(param1));
          local4 = int(this.inventoryNumStepper.value);
        } else if(!param2 && Boolean(itemService.isModificationItem(param1))) {
          this.inventoryNumStepper.visible = false;
          this.inventoryNumStepper.enabled = false;
          local7 = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
          local5 = int(itemService.getPrice(local7));
          local8 = int(itemService.getMinRankIndex(local7));
          local3 = userPropertiesService.rank >= local8 ? local8 : int(-local8);
        } else {
          local5 = int(itemService.getPrice(param1));
          this.inventoryNumStepper.visible = false;
          this.inventoryNumStepper.enabled = false;
        }
        this.updateBuyButtonText(param1,param2);
        this.buyButton.setInfo(local5,local4,local3,itemService.isPremiumItem(param1));
      } else {
        this.inventoryNumStepper.visible = false;
      }
    }

    private function setButtonsVisibility(param1:IGameObject, param2:Boolean, param3:Vector.<IGameObject>) : void {
      if(itemService.isGivenPresent(param1)) {
        this.deletePresentButton.visible = true;
        this.buyButton.visible = false;
        this.equipButton.visible = false;
      } else {
        this.deletePresentButton.visible = false;
        if(param2) {
          this.buyButton.visible = true;
          this.equipButton.visible = false;
        } else if(this.itemCategory == ItemCategoryEnum.INVENTORY) {
          this.buyButton.visible = true;
          this.equipButton.visible = false;
        } else {
          this.buyButton.visible = false;
          if(this.itemCategory == ItemCategoryEnum.PLUGIN || this.itemCategory == ItemCategoryEnum.EMBLEM || this.itemCategory == ItemCategoryEnum.LICENSE) {
            this.equipButton.visible = false;
          } else {
            this.equipButton.visible = true;
            if(itemService.isModificationItem(param1)) {
              this.buyButton.visible = itemService.getModificationIndex(param1) < 3 && param3.length > 1;
            }
          }
        }
      }
      this.devicesPanel.visible = this.divicesPanelVisible;
    }

    private function showItemProperties(param1:IGameObject, param2:Boolean, param3:Vector.<IGameObject>) : void {
      var local6:Boolean = false;
      var local7:int = 0;
      var local8:ItemPropertyValue = null;
      var local9:ItemPropertyParams = null;
      var local10:int = 0;
      var local11:int = 0;
      var local12:IGameObject = null;
      var local13:ModInfoRow = null;
      var local14:UpgradableItemParams = null;
      var local15:Vector.<UpgradableItemPropertyValue> = null;
      var local4:Boolean = !itemService.isModificationItem(param1);
      var local5:Vector.<ItemPropertyValue> = itemService.getPropertiesForInfoWindow(param1);
      if(local5 != null && local5.length > 0) {
        this.propertiesParams.length = local5.length;
        local6 = Boolean(itemService.isUpgradableItem(param1)) && itemService.getUpgradableItemParams(param1).getLevelsCount() > 0;
        local7 = 0;
        while(local7 < local5.length) {
          local8 = local5[local7];
          local9 = propertyService.getParams(local8.getProperty());
          this.propertiesParams[local7] = local9;
          if(local4) {
            local10 = UpgradeColors.getColorForItem(param1,local8);
            local9.icon.setValue(itemService.getCurrentValue(param1,local8),local10);
          } else {
            local9.icon.removeValue();
          }
          local7++;
        }
        this.upgradeButton.visible = this.enabledUpgrades && !param2 && local6;
        this.showIcons();
        if(!this.scrollContainer.contains(this.propertiesPanel)) {
          this.scrollContainer.addChild(this.propertiesPanel);
        }
      } else {
        this.upgradeButton.visible = false;
        this.propertiesParams.length = 0;
        if(this.scrollContainer.contains(this.propertiesPanel)) {
          this.scrollContainer.removeChild(this.propertiesPanel);
        }
      }
      if(itemService.isModificationItem(param1)) {
        this.propertiesPanelLeft.bitmapData = ItemInfoPanelBitmaps.upgradeTableLeft;
        this.propertiesPanelCenter.bitmapData = ItemInfoPanelBitmaps.upgradeTableCenter;
        this.propertiesPanelRight.bitmapData = ItemInfoPanelBitmaps.upgradeTableRight;
        this.showModTable();
        if(param2) {
          this.modTable.resetSelection();
        } else {
          this.modTable.select(itemService.getModificationIndex(param1));
        }
        local11 = 0;
        while(local11 < this.modTable.rows.length) {
          local13 = ModInfoRow(this.modTable.rows[local11]);
          local13.visible = param3.length != 1 || local11 == 0;
          local11++;
        }
        local11 = 0;
        while(local11 < param3.length) {
          local12 = param3[local11];
          local13 = ModInfoRow(this.modTable.rows[local11]);
          local13.upgradeIndicator.visible = param3.length != 1;
          local13.costLabel.text = Money.numToString(itemService.getPriceWithoutDiscount(local12),false);
          this.modTable.maxCostWidth = local13.costLabel.width;
          local13.rankIcon.setDefaultAccount(itemService.getMinRankIndex(local12));
          local14 = itemService.getUpgradableItemParams(local12);
          local15 = local14.visibleProperties;
          local13.setLabelsNum(local5.length);
          local13.setLabelsText(local14,local15);
          local11++;
        }
        this.modTable.correctNonintegralValues();
      } else {
        this.propertiesPanelLeft.bitmapData = ItemInfoPanelBitmaps.propertiesLeft;
        this.propertiesPanelCenter.bitmapData = ItemInfoPanelBitmaps.propertiesCenter;
        this.propertiesPanelRight.bitmapData = ItemInfoPanelBitmaps.propertiesRight;
        this.hideModTable();
      }
    }

    private function updateBuyButtonText(param1:IGameObject, param2:Boolean) : void {
      var local4:IGameObject = null;
      var local3:String = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT);
      if(itemService.isModificationItem(param1)) {
        if(param2) {
          local4 = itemService.getMaxAvailableModification(param1);
          if(local4 == null) {
            local4 = param1;
          }
        } else {
          local4 = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
        }
        this.buyButton.setText(local3 + " M" + itemService.getModificationIndex(local4));
      } else {
        this.buyButton.setText(local3);
      }
    }

    private function showKitInfoTable(param1:IGameObject) : void {
      if(!this.scrollContainer.contains(this.kitInfoPanel)) {
        this.scrollContainer.addChild(this.kitInfoPanel);
      }
      if(!this.scrollContainer.contains(this.kitInfoTable)) {
        this.scrollContainer.addChild(this.kitInfoTable);
      }
      this.kitInfoTable.show(param1);
    }

    private function hideKitInfoTable() : void {
      if(this.scrollContainer.contains(this.kitInfoPanel)) {
        this.scrollContainer.removeChild(this.kitInfoPanel);
      }
      if(this.scrollContainer.contains(this.kitInfoTable)) {
        this.scrollContainer.removeChild(this.kitInfoTable);
      }
    }

    public function updateEquipButton() : void {
      this.updateLabelEquipButton();
      if(Boolean(lobbyLayoutService.inBattle()) && !battleInfoService.reArmorEnabled && itemService.getCategory(this.item) != ItemCategoryEnum.PAINT) {
        this.equipButton.enabled = false;
        return;
      }
      if(this.itemCouldBeMounted()) {
        this.controlTimerEquipButton();
      } else {
        this.equipButton.enabled = false;
        this.equipButton.hideTime();
      }
    }

    private function updateLabelEquipButton() : void {
      if(this.itemCouldBeMounted()) {
        this.equipButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
      } else {
        this.equipButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_EQUIPPED_TEXT);
      }
    }

    private function itemCouldBeMounted() : Boolean {
      return Boolean(itemService.isMountable(this.item)) && Boolean(itemService.hasItem(this.item)) && !itemService.isMounted(this.item);
    }

    private function updateFittingButton(param1:Boolean, param2:IGameObject, param3:IGameObject) : void {
      if(param1 && itemService.getCategory(param3) == ItemCategoryEnum.PAINT && !battleInfoService.isInBattle()) {
        this.fittingButton.visible = true;
        if(param2 != param3) {
          this.fittingButton.enabled = true;
        }
      } else {
        this.fittingButton.visible = false;
      }
    }

    private function controlTimerEquipButton() : void {
      var local1:CountDownTimer = delayMountCategoryService.getDownTimer(this.item);
      if(itemService.getCategory(this.item) != ItemCategoryEnum.PAINT && Boolean(lobbyLayoutService.inBattle()) && local1.getRemainingSeconds() > 0 && !itemService.isMounted(this.item)) {
        this.equipButton.startTimer(local1);
        this.equipButton.addEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      } else {
        this.equipButton.hideTime();
        this.equipButton.enabled = true;
      }
    }

    private function onCompletedTimer(param1:TimerButtonEvent) : void {
      this.equipButton.enabled = true;
      this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
    }

    public function upgradeSelectedItem() : void {
      userGarageActionsService.upgradeItem(this.item);
      dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED));
    }

    private function openUpgradeWindow(param1:ItemPropertyUpgradeEvent) : * {
      var local2:UpgradableItemParams = itemService.getUpgradableItemParams(this.item);
      this.showSelectUpgradeWindow(local2);
    }

    private function onButtonUpgradeClick(param1:MouseEvent) : void {
      this.upgradeSelectedItem();
    }

    public function onMountItem() : void {
      if(this.item == null) {
        return;
      }
      if(!this.oldActionButtonsContainer.visible) {
        ItemActionPanel(this.item.event(ItemActionPanel)).updateActionElements(this.actionButtonsContainer,this);
      } else {
        this.updateEquipButton();
      }
    }

    private function showSelectUpgradeWindow(param1:UpgradableItemParams) : void {
      this.selectWindow = new SelectUpgradeWindow(param1);
      this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_CLOSED,this.onSelectWindowClosed);
      this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.SPEED_UP,this.onSpeedUp);
      this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.UPGRADE_STARTED,this.onUpgradeStarted);
      this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.FLUSH_UPGRADES,this.onFlushUpgrades);
      this.selectWindow.openDialog();
    }

    private function onSelectWindowClosed(param1:Event) : void {
      this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_CLOSED,this.onSelectWindowClosed);
      this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.SPEED_UP,this.onSpeedUp);
      this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.UPGRADE_STARTED,this.onUpgradeStarted);
      this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.FLUSH_UPGRADES,this.onFlushUpgrades);
      dialogService.removeDialog(this.selectWindow);
      this.selectWindow = null;
      this.updateEquipButton();
    }

    private function updateUpgradeButton(param1:IGameObject) : void {
      var local2:UpgradableItem = null;
      if(param1.hasModel(UpgradableItem)) {
        local2 = UpgradableItem(param1.adapt(UpgradableItem));
        if(local2.isUpgrading()) {
          this.upgradeButton.setUpgradingButton(local2.getCountDownTimer(),local2.hasSpeedUpDiscount());
        } else if(itemService.isFullUpgraded(param1)) {
          this.upgradeButton.setUpgradedButton();
        } else {
          this.upgradeButton.setUpgradeButton(local2.hasUpgradeDiscount());
        }
      }
    }

    private function onFlushUpgrades(param1:ItemPropertyUpgradeEvent) : void {
      dispatchEvent(new ItemPropertyUpgradeEvent(param1.type));
    }

    private function onSpeedUp(param1:ItemPropertyUpgradeEvent) : void {
      var local2:UpgradableItem = UpgradableItem(this.item.adapt(UpgradableItem));
      dispatchEvent(new ItemPropertyUpgradeEvent(param1.type,local2.getCountDownTimer(),param1.getPrice()));
    }

    private function onUpgradeStarted(param1:ItemPropertyUpgradeEvent) : void {
      var local2:UpgradableItem = UpgradableItem(this.item.adapt(UpgradableItem));
      this.upgradeButton.setUpgradingButton(param1.getTimer(),local2.hasSpeedUpDiscount());
      dispatchEvent(new ItemPropertyUpgradeEvent(param1.type,param1.getTimer(),param1.getPrice()));
      this.startBlinkEffects();
      if(!this.oldActionButtonsContainer.visible) {
        this.item.event(ItemActionPanel).updateActionElements(this.actionButtonsContainer,this);
      }
    }

    private function setButtonsPosition() : void {
      var local1:int = int(this.actionButtonsContainer.y);
      if(this.buyButton.visible) {
        this.buyButton.y = local1;
        if(this.isCountable) {
          this.inventoryNumStepper.x = -7;
          this.inventoryNumStepper.y = this.buyButton.y + (BUTTON_SIZE.y - this.inventoryNumStepper.height >> 1);
          this.buyButton.x = this.inventoryNumStepper.x + this.inventoryNumStepper.width + 10;
        } else {
          this.buyButton.x = this.margin;
        }
      }
      if(this.equipButton.visible) {
        this.equipButton.y = local1;
        this.equipButton.x = this.size.x - this.margin - BUTTON_SIZE.x;
      }
      if(this.fittingButton.visible) {
        this.fittingButton.y = local1;
        this.fittingButton.x = this.size.x - this.margin - BUTTON_SIZE.x;
      }
      this.upgradeButton.y = local1;
      this.upgradeButton.x = this.margin + BUTTON_SIZE.x + 15;
      this.deletePresentButton.x = this.margin;
      this.deletePresentButton.y = local1;
      this.equipButton.y = this.actionButtonsContainer.y;
      this.fittingButton.y = this.actionButtonsContainer.y;
      this.upgradeButton.y = this.actionButtonsContainer.y;
      this.buyButton.y = this.actionButtonsContainer.y;
    }

    public function resize(param1:int, param2:int) : void {
      var local3:int = 0;
      var local9:int = 0;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:int = 0;
      var local14:ItemPropertyIcon = null;
      var local15:ModInfoRow = null;
      var local16:Vector.<Number> = null;
      var local17:BitmapData = null;
      this.scrollPane.update();
      this.size.x = param1;
      this.size.y = param2;
      this.window.width = param1;
      this.window.height = param2;
      this.inner.width = param1 - this.margin * 2;
      this.inner.height = param2 - this.margin - BOTTOM_MARGIN;
      this.areaRect.width = param1 - this.margin * 2 - 2;
      this.areaRect2.width = this.areaRect.width - HORIZONTAL_MARGIN * 2;
      this.itemDescriptionLabel.x = HORIZONTAL_MARGIN - 3;
      this.itemDescriptionLabel.width = this.areaRect2.width;
      var local4:int = int(this.propertiesParams.length);
      if(local4 > 0) {
        local3 = this.propertiesPanel.y + this.propertiesPanel.height + VERTICAL_MARGIN;
        this.propertiesPanelRight.x = this.areaRect2.width - this.propertiesPanelRight.width;
        this.propertiesPanelCenter.width = this.propertiesPanelRight.x - this.propertiesPanelCenter.x;
        local9 = 6;
        local10 = ItemInfoPanelBitmaps.armor.width * local4 + ICON_SPACING_H * (local4 - 1);
        local11 = local10;
        if(this.scrollContainer.contains(this.modTable)) {
          local11 += this.modTable.constWidth;
        }
        local12 = this.propertiesPanel.width - local11 >> 1;
        if(!itemService.isModificationItem(this.item)) {
          local13 = 0;
          while(local13 < local4) {
            local14 = this.propertiesParams[local13].icon;
            local14.x = local12 + local13 * (ItemInfoPanelBitmaps.armor.width + ICON_SPACING_H);
            local14.y = local9;
            local13++;
          }
        } else {
          for each(local15 in this.modTable.rows) {
            local15.updatePositions();
          }
          local16 = local15.getPositions();
          local13 = 0;
          while(local13 < local16.length) {
            local14 = this.propertiesParams[local13].icon;
            local14.x = local16[local13] - local14.width / 2;
            local14.y = local9;
            local13++;
          }
          this.modTable.y = this.propertiesPanel.y + local14.height + 2;
        }
        this.itemDescriptionLabel.y = this.propertiesPanel.y + this.propertiesPanel.height + VERTICAL_MARGIN - 4;
      } else {
        this.itemDescriptionLabel.y = this.areaRect2.y + 24 - 7;
      }
      if(this.divicesPanelVisible) {
        this.devicesPanel.y = this.itemDescriptionLabel.y;
        this.itemDescriptionLabel.y += this.devicesPanel.height + 5;
        if(this.descriptionCaptionLabel.visible) {
          this.descriptionCaptionLabel.y = this.itemDescriptionLabel.y;
          this.itemDescriptionLabel.y += this.descriptionCaptionLabel.height + 5;
        }
      }
      if(this.kitFullImage.bitmapData != null) {
        this.kitFullImage.y = this.itemNameLabel.y + this.itemNameLabel.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
        this.kitFullImage.x = this.scrollContainer.width - this.kitFullImage.width >> 1;
        this.itemDescriptionLabel.y += this.kitFullImage.bitmapData.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
      }
      if(this.presentFullImage.bitmapData != null) {
        this.presentFullImage.y = this.itemNameLabel.y + this.itemNameLabel.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
        this.presentFullImage.x = this.scrollContainer.width - this.presentFullImage.width >> 1;
        this.itemDescriptionLabel.y += this.presentFullImage.bitmapData.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
      }
      local3 += VERTICAL_MARGIN + this.itemDescriptionLabel.textHeight - 4;
      var local5:int = local3;
      var local6:Boolean = this.itemPreview.bitmapData != null;
      if(local6) {
        this.itemPreview.x = this.margin;
        this.itemPreview.y = this.itemDescriptionLabel.y;
        this.itemDescriptionLabel.x = this.itemPreview.x + this.itemPreview.width + 5;
        this.itemDescriptionLabel.width = this.areaRect2.width - this.itemDescriptionLabel.x + this.margin;
        local3 = Math.max(this.itemDescriptionLabel.y + 3 + this.itemDescriptionLabel.textHeight + VERTICAL_MARGIN,this.itemPreview.y + this.itemPreview.height + VERTICAL_MARGIN);
      } else {
        local3 = this.itemDescriptionLabel.y + 3 + this.itemDescriptionLabel.textHeight + VERTICAL_MARGIN;
      }
      var local7:* = this.showEquippedPanel(this.inner) - 2 - MODULE_SPACING * 2;
      var local8:int = Math.max(local3,local7);
      this.areaRect.height = local8;
      this.areaRect2.height = this.area.height - VERTICAL_MARGIN * 2;
      if(local8 > param2 - this.margin - BOTTOM_MARGIN - 2 - MODULE_SPACING * 2) {
        local6 = false;
        this.itemDescriptionLabel.x = HORIZONTAL_MARGIN - 3;
        this.itemDescriptionLabel.width = this.areaRect2.width;
        local3 = local5;
        local8 = Math.max(local3,local7);
        this.areaRect.height = local8;
        this.areaRect2.height = this.inner.height - VERTICAL_MARGIN * 2;
      }
      if(this.isKit) {
        this.updateKitPreview(this.kitFullImage);
        this.kitInfoPanel.y = this.kitFullImage.bitmapData != null && Boolean(this.scrollContainer.contains(this.kitFullImage)) ? int(this.kitFullImage.height + this.itemNameLabel.height + KIT_INFO_TOP_MARGIN * 2) : int(this.itemNameLabel.height) + KIT_INFO_TOP_MARGIN;
        this.kitInfoTable.y = this.kitInfoPanel.y;
        this.itemDescriptionLabel.y = this.kitInfoPanel.y + this.kitInfoTable.getFullTableHeight() + 10;
        this.kitInfoPanelTopRightCorner.x = this.areaRect2.width - this.kitInfoPanelTopRightCorner.width;
        this.kitInfoPanelCenterTopLine.width = this.kitInfoPanelTopRightCorner.x - this.kitInfoPanelCenterTopLine.x;
        this.kitInfoPanelLeftLine.y = this.kitInfoPanelTopLeftCorner.height;
        this.kitInfoPanelLeftLine.height = this.kitInfoTable.getTopPartTableHeight();
        this.kitInfoPanelRightLine.y = this.kitInfoPanelTopRightCorner.height;
        this.kitInfoPanelRightLine.height = this.kitInfoPanelLeftLine.height;
        this.kitInfoPanelRightLine.x = this.areaRect2.width - this.kitInfoPanelRightLine.width;
        this.kitInfoPanelLeftCenterLine.y = this.kitInfoPanelLeftLine.height + this.kitInfoPanelTopLeftCorner.height;
        this.kitInfoPanelRightCenterLine.y = this.kitInfoPanelLeftCenterLine.y;
        this.kitInfoPanelRightCenterLine.x = this.kitInfoPanelRightLine.x;
        this.kitInfoPanelCenterMiddleLine.x = this.kitInfoPanelLeftCenterLine.width;
        this.kitInfoPanelCenterMiddleLine.y = this.kitInfoPanelRightCenterLine.y;
        this.kitInfoPanelCenterMiddleLine.width = this.kitInfoPanelRightCenterLine.x - this.kitInfoPanelCenterMiddleLine.x;
        this.kitInfoPanelLeftLineCenterSummary.y = this.kitInfoPanelCenterMiddleLine.y + this.kitInfoPanelCenterMiddleLine.height;
        this.kitInfoPanelLeftLineCenterSummary.height = this.kitInfoTable.getBottomPartTableHeight();
        this.kitInfoPanelRightLineCenterSummary.y = this.kitInfoPanelLeftLineCenterSummary.y;
        this.kitInfoPanelRightLineCenterSummary.height = this.kitInfoPanelLeftLineCenterSummary.height;
        this.kitInfoPanelRightLineCenterSummary.x = this.kitInfoPanelRightLine.x;
        this.kitInfoPanelLeftLineSummary.y = this.kitInfoPanelLeftLineCenterSummary.y + this.kitInfoPanelLeftLineCenterSummary.height;
        this.kitInfoPanelRightLineSummary.y = this.kitInfoPanelLeftLineSummary.y;
        this.kitInfoPanelRightLineSummary.x = this.kitInfoPanelRightCenterLine.x;
        this.kitInfoPanelCenterBottomLine.y = this.kitInfoPanelLeftLineSummary.y + this.kitInfoPanelLeftLineSummary.height - this.kitInfoPanelCenterBottomLine.height;
        this.kitInfoPanelCenterBottomLine.x = this.kitInfoPanelLeftLineSummary.width;
        this.kitInfoPanelCenterBottomLine.width = this.kitInfoPanelCenterTopLine.width;
        local17 = ItemInfoPanelBitmaps.backgroundPixelTableKit;
        this.kitInfoPanelBackgroundUp.graphics.clear();
        this.kitInfoPanelBackgroundUp.graphics.beginBitmapFill(local17);
        this.kitInfoPanelBackgroundUp.graphics.drawRect(this.kitInfoPanelTopLeftCorner.width,this.kitInfoPanelTopLeftCorner.height,this.kitInfoPanelCenterTopLine.width,this.kitInfoPanelLeftLine.height);
        this.kitInfoPanelBackgroundBottom.graphics.clear();
        this.kitInfoPanelBackgroundBottom.graphics.beginBitmapFill(local17);
        this.kitInfoPanelBackgroundBottom.graphics.drawRect(this.kitInfoPanelLeftCenterLine.width,this.kitInfoPanelLeftCenterLine.y + this.kitInfoPanelLeftCenterLine.height,this.kitInfoPanelCenterBottomLine.width,this.kitInfoPanelLeftLineCenterSummary.height);
      }
      if(Boolean(this.item) && Boolean(itemService.isGivenPresent(this.item))) {
        this.presentInfoPanel.y = this.presentFullImage.bitmapData != null && Boolean(this.scrollContainer.contains(this.presentFullImage)) ? this.presentFullImage.height + this.itemNameLabel.height + 20 : this.itemNameLabel.height + 10;
        this.presentInfoPanel.setMessageWidth(this.areaRect2.width);
      }
      this.area.graphics.clear();
      this.area.graphics.beginFill(16711680,0);
      this.area.graphics.drawRect(this.areaRect.x,this.areaRect.y,this.areaRect.width,this.areaRect.height);
      if(local6) {
        if(this.item != null && this.itemPreview != null && this.itemPreview.parent == null) {
          this.showBitmap(this.itemPreview);
          GarageResistancesIconsUtils.addIconsToParent(this.itemPreview,this.item);
        }
      } else {
        removeDisplayObject(this.itemPreview);
      }
      this.actionButtonsContainer.y = this.size.y - this.margin - BUTTON_SIZE.y + 1;
      this.setButtonsPosition();
      if(this.resistPanel.visible) {
        this.resistPanel.y = this.actionButtonsContainer.y - this.resistPanel.height - VERTICAL_MARGIN / 2;
        this.resistPanel.x = this.inner.x;
      }
      this.scrollPane.setSize(param1 - this.margin * 2 - 2 + 6,local7);
      this.scrollPane.update();
      this.resizeTimeIndicator();
    }

    private function resizeTimeIndicator() : void {
      if(this.scrollContainer.contains(this.timeIndicator)) {
        this.timeIndicator.x = this.areaRect2.x + this.areaRect2.width - this.timeIndicator.width + 3;
        this.timeIndicator.y = this.areaRect2.y - 7;
      }
    }

    public function hideModTable() : void {
      if(this.scrollContainer.contains(this.modTable)) {
        this.scrollContainer.removeChild(this.modTable);
      }
    }

    public function showModTable() : void {
      if(!this.scrollContainer.contains(this.modTable)) {
        this.scrollContainer.addChild(this.modTable);
      }
    }

    private function updateKitPreview(param1:Bitmap) : void {
      if(this.kitFullImage.height > 0) {
        param1.y += KIT_INFO_TOP_MARGIN;
        this.kitItemTopPreviewDiscount.text = "-" + itemService.getDiscount(this.item) + "%";
        this.kitItemTopPreviewDiscount.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
        this.kitItemTopPreviewDiscount.x = 302;
        this.kitItemTopPreviewDiscount.y = int(this.itemNameLabel.height + KIT_INFO_TOP_MARGIN) + 168;
        if(localeService.language == "cn") {
          this.kitItemTopPreviewDiscount.x = 300;
        }
        if(!this.scrollContainer.contains(this.kitItemTopPreviewDiscount)) {
          this.scrollContainer.addChild(this.kitItemTopPreviewDiscount);
        } else {
          this.scrollContainer.removeChild(this.kitItemTopPreviewDiscount);
          this.scrollContainer.addChild(this.kitItemTopPreviewDiscount);
        }
      }
    }

    private function showBitmap(param1:Bitmap) : void {
      if(param1.bitmapData != null && !this.itemPreviewContainer.contains(param1)) {
        this.itemPreviewContainer.addChild(param1);
      }
    }

    private function setTimeRemaining(param1:IGameObject) : void {
      var local2:ITemporaryItem = ITemporaryItem(param1.adapt(ITemporaryItem));
      var local3:Date = local2.getStopDate();
      this.timeIndicator.text = DateTimeHelper.formatDateTimeWithExpiredLabel(local3);
      this.resizeTimeIndicator();
    }

    private function inventoryNumChanged(param1:Event = null) : void {
      var local2:int = getRequiredRank(this.minRankIndex,this.maxRankIndex);
      var local3:int = this.isCountable ? int(this.inventoryNumStepper.value) : 1;
      userGarageActionsService.chooseItemCount(this.item);
      this.buyButton.setInfo(itemService.getPrice(this.item),local3,local2,itemService.isPremiumItem(this.item));
      this.setButtonsPosition();
    }

    public function itemUpgraded() : void {
      if(this.selectWindow != null) {
        this.selectWindow.itemUpgraded();
      }
      this.showItemInfo(this.item,false);
      this.resize(this.size.x,this.size.y);
      this.stopBlinkEffects();
      this.doSomethingForEachLabel(this.showGlowEffect);
    }

    private function showGlowEffect(param1:int, param2:LabelBase) : void {
      GlowEffect.glow(param2,param2.textColor);
    }

    private function updateBlinkEffect() : void {
      if(itemService.isUpgrading(this.item)) {
        this.startBlinkEffects();
      } else {
        this.stopBlinkEffects();
      }
    }

    private function startBlinkEffects() : void {
      this.doSomethingForEachLabel(this.startBlinkEffect);
    }

    private function doSomethingForEachLabel(param1:Function) : void {
      var local4:int = 0;
      var local5:ModInfoRow = null;
      var local6:int = 0;
      var local7:int = 0;
      var local8:LabelBase = null;
      var local2:Vector.<UpgradableItemPropertyValue> = itemService.getUpgradableItemParams(this.item).visibleProperties;
      var local3:uint = local2.length;
      if(itemService.isModificationItem(this.item)) {
        local4 = int(itemService.getModificationIndex(this.item));
        local5 = this.modTable.rows[local4];
        local6 = 0;
        while(local6 < local3) {
          if(local2[local6].isUpgradable()) {
            param1(local6,local5.labels[local6]);
          }
          local6++;
        }
      } else {
        local7 = 0;
        while(local7 < local2.length) {
          if(local2[local7].isUpgradable()) {
            local8 = propertyService.getParams(local2[local7].getProperty()).icon.getLabel();
            param1(local7,local8);
          }
          local7++;
        }
      }
    }

    private function startBlinkEffect(param1:int, param2:DisplayObject) : void {
      if(this.blinkEffects[param1] == null) {
        this.blinkEffects[param1] = new BlinkEffect();
      }
      BlinkEffect(this.blinkEffects[param1]).start(param2);
    }
  }
}
