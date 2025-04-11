package projects.tanks.clients.fp10.models.tankspanelmodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.calculators.ExchangeCalculator;
  import alternativa.tanks.font.services.TanksFontsFormatService;
  import alternativa.tanks.gui.AntiAddictionWindow;
  import alternativa.tanks.gui.AvailableItemsAlert;
  import alternativa.tanks.gui.CongratulationsWindowConfiscate;
  import alternativa.tanks.gui.CongratulationsWindowPresent;
  import alternativa.tanks.gui.CongratulationsWindowWithBanner;
  import alternativa.tanks.gui.EmailBlock;
  import alternativa.tanks.gui.EmailReminderWindow;
  import alternativa.tanks.gui.EntranceAlertWindow;
  import alternativa.tanks.gui.RankUpSupplyBonusAlert;
  import alternativa.tanks.gui.RepatriateBonusWindow;
  import alternativa.tanks.gui.RulesUpdateAlert;
  import alternativa.tanks.gui.ThanksForPurchaseWindow;
  import alternativa.tanks.gui.alerts.ItemsAlert;
  import alternativa.tanks.gui.alerts.RankUpBonusAlert;
  import alternativa.tanks.gui.battle.BattleFinishNotification;
  import alternativa.tanks.gui.buycrystals.BuyCrystalsAlert;
  import alternativa.tanks.gui.crystalbutton.CrystalButton;
  import alternativa.tanks.gui.effects.BlinkEffect;
  import alternativa.tanks.gui.effects.FlashEffect;
  import alternativa.tanks.gui.effects.GlowEffect;
  import alternativa.tanks.gui.error.ErrorForm;
  import alternativa.tanks.gui.error.ErrorNotification;
  import alternativa.tanks.gui.friends.AddRequestView;
  import alternativa.tanks.gui.friends.FriendsWindow;
  import alternativa.tanks.gui.friends.battleLink.BattleLink;
  import alternativa.tanks.gui.friends.battleinvite.BattleInviteNotification;
  import alternativa.tanks.gui.friends.button.friends.NewRequestIndicator;
  import alternativa.tanks.gui.friends.button.friends.RequestCountIndicator;
  import alternativa.tanks.gui.friends.list.AcceptedList;
  import alternativa.tanks.gui.friends.list.ClanMembersList;
  import alternativa.tanks.gui.friends.list.FriendsList;
  import alternativa.tanks.gui.friends.list.IncomingList;
  import alternativa.tanks.gui.friends.list.dataprovider.FriendsDataProvider;
  import alternativa.tanks.gui.friends.list.refferals.ReferralForm;
  import alternativa.tanks.gui.friends.list.refferals.ReferralStatHeader;
  import alternativa.tanks.gui.friends.list.refferals.referalbuttons.LinkReferralButton;
  import alternativa.tanks.gui.friends.list.refferals.referalbuttons.OkReferralButton;
  import alternativa.tanks.gui.friends.list.refferals.referalbuttons.VkReferralButton;
  import alternativa.tanks.gui.friends.list.renderer.ClanMembersListRenderer;
  import alternativa.tanks.gui.friends.list.renderer.FriendsAcceptedListRenderer;
  import alternativa.tanks.gui.friends.list.renderer.FriendsIncomingListRenderer;
  import alternativa.tanks.gui.friends.list.renderer.HeaderAcceptedList;
  import alternativa.tanks.gui.itemslist.PartsListRenderer;
  import alternativa.tanks.gui.newbiesabonement.NewbiesAbonementInfoWindow;
  import alternativa.tanks.gui.panel.ButtonBar;
  import alternativa.tanks.gui.panel.MainPanel;
  import alternativa.tanks.gui.panel.PlayerInfo;
  import alternativa.tanks.gui.panel.StarsCashLabel;
  import alternativa.tanks.gui.panel.buttons.ClanButton;
  import alternativa.tanks.gui.panel.buttons.QuestsButton;
  import alternativa.tanks.gui.payment.controls.BonusLabel;
  import alternativa.tanks.gui.payment.controls.PremiumLabel;
  import alternativa.tanks.gui.payment.controls.exchange.ExchangeGroup;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.gate2shop.Gate2ShopForm;
  import alternativa.tanks.gui.payment.forms.leogaming.LeogamingCodeConfirmForm;
  import alternativa.tanks.gui.payment.forms.leogaming.LeogamingMobileForm;
  import alternativa.tanks.gui.payment.forms.leogaming.LeogamingPhoneForm;
  import alternativa.tanks.gui.payment.forms.mobile.PhoneNumberInput;
  import alternativa.tanks.gui.payment.forms.platbox.PlatBoxForm;
  import alternativa.tanks.gui.payment.forms.platbox.PlatboxPhoneNumberForm;
  import alternativa.tanks.gui.payment.forms.qiwi.QiwiPhoneNumberForm;
  import alternativa.tanks.gui.personaldiscount.PersonalDiscountAlert;
  import alternativa.tanks.gui.premiumaccount.PremiumAccountWelcomeAlert;
  import alternativa.tanks.gui.presents.NewPresentsAlert;
  import alternativa.tanks.gui.selectcountry.SelectCountryAlert;
  import alternativa.tanks.gui.settings.SettingsTabButtonList;
  import alternativa.tanks.gui.settings.SettingsWindow;
  import alternativa.tanks.gui.settings.tabs.SettingsTabView;
  import alternativa.tanks.gui.settings.tabs.SoundSettingsTab;
  import alternativa.tanks.gui.settings.tabs.account.AccountSettingsTab;
  import alternativa.tanks.gui.settings.tabs.control.ControlSettingsTab;
  import alternativa.tanks.gui.settings.tabs.control.KeyBinding;
  import alternativa.tanks.gui.settings.tabs.control.KeyBindingsPanel;
  import alternativa.tanks.gui.settings.tabs.game.GameSettingsTab;
  import alternativa.tanks.gui.shop.components.notification.ShopNotificationIndicator;
  import alternativa.tanks.gui.shop.components.window.ShopWindowCountrySelector;
  import alternativa.tanks.gui.shop.components.window.ShopWindowNavigationBar;
  import alternativa.tanks.gui.shop.forms.ApproveOneTimePurchaseForm;
  import alternativa.tanks.gui.shop.forms.SMSForm;
  import alternativa.tanks.gui.shop.forms.WaitUrlForm;
  import alternativa.tanks.gui.shop.payment.PayModeChooseView;
  import alternativa.tanks.gui.shop.payment.PaymentFormOneTimePurchaseView;
  import alternativa.tanks.gui.shop.payment.PaymentFormView;
  import alternativa.tanks.gui.shop.payment.promo.PromoCodeActivateForm;
  import alternativa.tanks.gui.shop.shopitems.GoodsChooseView;
  import alternativa.tanks.gui.shop.shopitems.item.OtherShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.cashpackage.CashPackageButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.description.KitPackageDescriptionView;
  import alternativa.tanks.gui.shop.shopitems.item.licenseclan.LicenseClanButton;
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import alternativa.tanks.gui.shop.windows.bugreport.PaymentBugReportBlock;
  import alternativa.tanks.gui.socialnetwork.AbstractSNGroupEnteringWindow;
  import alternativa.tanks.help.DateTimeHelper;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.abonements.UserAbonementsModel;
  import alternativa.tanks.model.achievement.AchievementModel;
  import alternativa.tanks.model.androidapprating.AndroidAppRatingModel;
  import alternativa.tanks.model.antiaddiction.AntiAddictionAlertModel;
  import alternativa.tanks.model.antiaddiction.IAntiAddictionAlert;
  import alternativa.tanks.model.antiaddiction.IAntiAddictionAlertAdapt;
  import alternativa.tanks.model.antiaddiction.IAntiAddictionAlertEvents;
  import alternativa.tanks.model.bonus.showing.image.BonusImageShowingModel;
  import alternativa.tanks.model.bonus.showing.info.BonusInfo;
  import alternativa.tanks.model.bonus.showing.info.BonusInfoAdapt;
  import alternativa.tanks.model.bonus.showing.info.BonusInfoEvents;
  import alternativa.tanks.model.bonus.showing.info.BonusInfoModel;
  import alternativa.tanks.model.bonus.showing.items.BonusItem;
  import alternativa.tanks.model.bonus.showing.items.BonusItemAdapt;
  import alternativa.tanks.model.bonus.showing.items.BonusItemEvents;
  import alternativa.tanks.model.bonus.showing.items.BonusItemModel;
  import alternativa.tanks.model.bonus.showing.items.BonusItemsShowingModel;
  import alternativa.tanks.model.challenge.ChallengeShopItemsModel;
  import alternativa.tanks.model.challenge.battlepass.BattlePassPackageModel;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseNotifierModel;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseService;
  import alternativa.tanks.model.coin.CoinInfoModel;
  import alternativa.tanks.model.coin.CoinInfoService;
  import alternativa.tanks.model.donation.DonationProfileModel;
  import alternativa.tanks.model.donationalert.DonationAlertModel;
  import alternativa.tanks.model.donationalert.ThanksForDonationFormService;
  import alternativa.tanks.model.donationalert.ThanksForDonationFormServiceAdapt;
  import alternativa.tanks.model.donationalert.ThanksForDonationFormServiceEvents;
  import alternativa.tanks.model.emailreminder.EmailReminderModel;
  import alternativa.tanks.model.emailreminder.EmailReminderService;
  import alternativa.tanks.model.emailreminder.EmailReminderServiceAdapt;
  import alternativa.tanks.model.emailreminder.EmailReminderServiceEvents;
  import alternativa.tanks.model.entrancealert.EntranceAlertModel;
  import alternativa.tanks.model.friends.battleinvite.BattleInviteModel;
  import alternativa.tanks.model.friends.loader.FriendsLoaderModel;
  import alternativa.tanks.model.garage.availableitems.AvailableItemsModel;
  import alternativa.tanks.model.garage.availableupgrades.AvailableUpgradesModel;
  import alternativa.tanks.model.garage.rankupsupplybonus.RankUpSupplyBonusModel;
  import alternativa.tanks.model.garage.resistance.ModuleResistances;
  import alternativa.tanks.model.garage.resistance.ModuleResistancesAdapt;
  import alternativa.tanks.model.garage.resistance.ModuleResistancesEvents;
  import alternativa.tanks.model.garage.resistance.ResistancesListModel;
  import alternativa.tanks.model.garage.upgradingitems.UpgradingItemsModel;
  import alternativa.tanks.model.kitoffer.KitOfferDialog;
  import alternativa.tanks.model.kitoffer.KitOfferModel;
  import alternativa.tanks.model.mobilequest.MobileQuestModel;
  import alternativa.tanks.model.mobilequest.MobileQuestProfileModel;
  import alternativa.tanks.model.newbiesabonement.NewbiesAbonementShowInfoModel;
  import alternativa.tanks.model.panel.PanelModel;
  import alternativa.tanks.model.panel.payment.PaymentButtonModel;
  import alternativa.tanks.model.panel.payment.load.PaymentLoaderModel;
  import alternativa.tanks.model.payment.CrystalsPaymentModel;
  import alternativa.tanks.model.payment.PaymentModel;
  import alternativa.tanks.model.payment.androidspecialoffer.AndroidBannerModel;
  import alternativa.tanks.model.payment.androidspecialoffer.AndroidPurchaseOfUpgradesModel;
  import alternativa.tanks.model.payment.androidspecialoffer.AndroidPurchaseOfUpgradesUserModel;
  import alternativa.tanks.model.payment.androidspecialoffer.AndroidSpecialOfferModel;
  import alternativa.tanks.model.payment.androidspecialoffer.MediumTimeOfferModel;
  import alternativa.tanks.model.payment.androidspecialoffer.ShopItemLoaderForAndroidModel;
  import alternativa.tanks.model.payment.category.PayFullDescription;
  import alternativa.tanks.model.payment.category.PayFullDescriptionAdapt;
  import alternativa.tanks.model.payment.category.PayFullDescriptionEvents;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.category.PayModeViewAdapt;
  import alternativa.tanks.model.payment.category.PayModeViewEvents;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentMode;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentModeAdapt;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentModeEvents;
  import alternativa.tanks.model.payment.modes.PayMode;
  import alternativa.tanks.model.payment.modes.PayModeAdapt;
  import alternativa.tanks.model.payment.modes.PayModeDescription;
  import alternativa.tanks.model.payment.modes.PayModeDescriptionAdapt;
  import alternativa.tanks.model.payment.modes.PayModeDescriptionEvents;
  import alternativa.tanks.model.payment.modes.PayModeEvents;
  import alternativa.tanks.model.payment.modes.PayModeManualDescription;
  import alternativa.tanks.model.payment.modes.PayModeManualDescriptionAdapt;
  import alternativa.tanks.model.payment.modes.PayModeManualDescriptionEvents;
  import alternativa.tanks.model.payment.modes.PayUrl;
  import alternativa.tanks.model.payment.modes.PayUrlAdapt;
  import alternativa.tanks.model.payment.modes.PayUrlEvents;
  import alternativa.tanks.model.payment.modes.PaymentModeModel;
  import alternativa.tanks.model.payment.modes.alipay.AlipayPaymentModel;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayModeAdapt;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayModeEvents;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayModel;
  import alternativa.tanks.model.payment.modes.braintree.BraintreePayment;
  import alternativa.tanks.model.payment.modes.braintree.BraintreePaymentAdapt;
  import alternativa.tanks.model.payment.modes.braintree.BraintreePaymentEvents;
  import alternativa.tanks.model.payment.modes.braintree.BraintreePaymentModel;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescription;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionAdapt;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionEvents;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionInternal;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionInternalAdapt;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionInternalEvents;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionModel;
  import alternativa.tanks.model.payment.modes.errors.ErrorDescription;
  import alternativa.tanks.model.payment.modes.errors.ErrorDescriptionAdapt;
  import alternativa.tanks.model.payment.modes.errors.ErrorDescriptionEvents;
  import alternativa.tanks.model.payment.modes.errors.ErrorsDescriptionModel;
  import alternativa.tanks.model.payment.modes.gate2shop.Gate2ShopPayment;
  import alternativa.tanks.model.payment.modes.gate2shop.Gate2ShopPaymentAdapt;
  import alternativa.tanks.model.payment.modes.gate2shop.Gate2ShopPaymentEvents;
  import alternativa.tanks.model.payment.modes.gate2shop.Gate2ShopPaymentModel;
  import alternativa.tanks.model.payment.modes.leogaming.LeogamingPaymentMobileModel;
  import alternativa.tanks.model.payment.modes.leogaming.LeogamingPaymentMode;
  import alternativa.tanks.model.payment.modes.leogaming.LeogamingPaymentModeAdapt;
  import alternativa.tanks.model.payment.modes.leogaming.LeogamingPaymentModeEvents;
  import alternativa.tanks.model.payment.modes.onlyurl.OnlyUrlPayMode;
  import alternativa.tanks.model.payment.modes.onlyurl.OnlyUrlPayModeAdapt;
  import alternativa.tanks.model.payment.modes.onlyurl.OnlyUrlPayModeEvents;
  import alternativa.tanks.model.payment.modes.onlyurl.OnlyUrlPaymentModel;
  import alternativa.tanks.model.payment.modes.paygarden.PayGardenPayment;
  import alternativa.tanks.model.payment.modes.paygarden.PayGardenPaymentAdapt;
  import alternativa.tanks.model.payment.modes.paygarden.PayGardenPaymentEvents;
  import alternativa.tanks.model.payment.modes.paygarden.PayGardenPaymentModel;
  import alternativa.tanks.model.payment.modes.paypal.PayPalPayment;
  import alternativa.tanks.model.payment.modes.paypal.PayPalPaymentAdapt;
  import alternativa.tanks.model.payment.modes.paypal.PayPalPaymentEvents;
  import alternativa.tanks.model.payment.modes.paypal.PayPalPaymentModel;
  import alternativa.tanks.model.payment.modes.platbox.PlatBoxPaymentModel;
  import alternativa.tanks.model.payment.modes.pricerange.PriceRange;
  import alternativa.tanks.model.payment.modes.pricerange.PriceRangeAdapt;
  import alternativa.tanks.model.payment.modes.pricerange.PriceRangeEvents;
  import alternativa.tanks.model.payment.modes.pricerange.PriceRangeModel;
  import alternativa.tanks.model.payment.modes.qiwi.QiwiPayment;
  import alternativa.tanks.model.payment.modes.qiwi.QiwiPaymentAdapt;
  import alternativa.tanks.model.payment.modes.qiwi.QiwiPaymentEvents;
  import alternativa.tanks.model.payment.modes.qiwi.QiwiPaymentModel;
  import alternativa.tanks.model.payment.modes.sms.SMSPayMode;
  import alternativa.tanks.model.payment.modes.sms.SMSPayModeAdapt;
  import alternativa.tanks.model.payment.modes.sms.SMSPayModeEvents;
  import alternativa.tanks.model.payment.modes.sms.SMSPayModeModel;
  import alternativa.tanks.model.payment.modes.terminal.TerminalPayMode;
  import alternativa.tanks.model.payment.modes.terminal.TerminalPayModeAdapt;
  import alternativa.tanks.model.payment.modes.terminal.TerminalPayModeEvents;
  import alternativa.tanks.model.payment.modes.terminal.TerminalPaymentModel;
  import alternativa.tanks.model.payment.modes.yandex.GoToUrlPaymentModel;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowServiceImpl;
  import alternativa.tanks.model.payment.saveprocessed.ProcessedPaymentService;
  import alternativa.tanks.model.payment.saveprocessed.ProcessedPaymentServiceImp;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsView;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsViewAdapt;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsViewEvents;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import alternativa.tanks.model.payment.shop.ShopItemViewAdapt;
  import alternativa.tanks.model.payment.shop.ShopItemViewEvents;
  import alternativa.tanks.model.payment.shop.cashpackage.CashPackage;
  import alternativa.tanks.model.payment.shop.cashpackage.CashPackageAdapt;
  import alternativa.tanks.model.payment.shop.cashpackage.CashPackageEvents;
  import alternativa.tanks.model.payment.shop.category.ShopCategory;
  import alternativa.tanks.model.payment.shop.category.ShopCategoryAdapt;
  import alternativa.tanks.model.payment.shop.category.ShopCategoryEvents;
  import alternativa.tanks.model.payment.shop.category.ShopCategoryModel;
  import alternativa.tanks.model.payment.shop.coin.CoinPackageModel;
  import alternativa.tanks.model.payment.shop.crystal.CrystalPackage;
  import alternativa.tanks.model.payment.shop.crystal.CrystalPackageAdapt;
  import alternativa.tanks.model.payment.shop.crystal.CrystalPackageEvents;
  import alternativa.tanks.model.payment.shop.crystal.CrystalPackageModel;
  import alternativa.tanks.model.payment.shop.description.ShopItemAdditionalDescription;
  import alternativa.tanks.model.payment.shop.description.ShopItemAdditionalDescriptionAdapt;
  import alternativa.tanks.model.payment.shop.description.ShopItemAdditionalDescriptionEvents;
  import alternativa.tanks.model.payment.shop.description.ShopItemAdditionalDescriptionModel;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscount;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscountAdapt;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscountEvents;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscountModel;
  import alternativa.tanks.model.payment.shop.emailrequired.EmailRequiredModel;
  import alternativa.tanks.model.payment.shop.emailrequired.ShopItemEmailRequired;
  import alternativa.tanks.model.payment.shop.emailrequired.ShopItemEmailRequiredAdapt;
  import alternativa.tanks.model.payment.shop.emailrequired.ShopItemEmailRequiredEvents;
  import alternativa.tanks.model.payment.shop.featuring.ShopItemFeaturing;
  import alternativa.tanks.model.payment.shop.featuring.ShopItemFeaturingAdapt;
  import alternativa.tanks.model.payment.shop.featuring.ShopItemFeaturingEvents;
  import alternativa.tanks.model.payment.shop.featuring.ShopItemFeaturingModel;
  import alternativa.tanks.model.payment.shop.goldbox.GoldBoxPackage;
  import alternativa.tanks.model.payment.shop.goldbox.GoldBoxPackageAdapt;
  import alternativa.tanks.model.payment.shop.goldbox.GoldBoxPackageEvents;
  import alternativa.tanks.model.payment.shop.goldbox.GoldBoxPackageModel;
  import alternativa.tanks.model.payment.shop.indemnity.Indemnity;
  import alternativa.tanks.model.payment.shop.indemnity.IndemnityAdapt;
  import alternativa.tanks.model.payment.shop.indemnity.IndemnityEvents;
  import alternativa.tanks.model.payment.shop.indemnity.IndemnityModel;
  import alternativa.tanks.model.payment.shop.item.ShopItem;
  import alternativa.tanks.model.payment.shop.item.ShopItemAdapt;
  import alternativa.tanks.model.payment.shop.item.ShopItemEvents;
  import alternativa.tanks.model.payment.shop.item.ShopItemModel;
  import alternativa.tanks.model.payment.shop.itemcategory.ShopItemCategory;
  import alternativa.tanks.model.payment.shop.itemcategory.ShopItemCategoryAdapt;
  import alternativa.tanks.model.payment.shop.itemcategory.ShopItemCategoryEvents;
  import alternativa.tanks.model.payment.shop.itemcategory.ShopItemCategoryModel;
  import alternativa.tanks.model.payment.shop.kit.KitPackage;
  import alternativa.tanks.model.payment.shop.kit.KitPackageAdapt;
  import alternativa.tanks.model.payment.shop.kit.KitPackageEvents;
  import alternativa.tanks.model.payment.shop.kit.KitPackageModel;
  import alternativa.tanks.model.payment.shop.kit.view.KitPackageViewModel;
  import alternativa.tanks.model.payment.shop.kitviewresource.KitViewButtonWithPriceModel;
  import alternativa.tanks.model.payment.shop.kitviewresource.KitViewResource;
  import alternativa.tanks.model.payment.shop.kitviewresource.KitViewResourceAdapt;
  import alternativa.tanks.model.payment.shop.kitviewresource.KitViewResourceEvents;
  import alternativa.tanks.model.payment.shop.kitviewresource.KitViewResourceModel;
  import alternativa.tanks.model.payment.shop.kitviewresource.localized.KitViewResourceLocalizedModel;
  import alternativa.tanks.model.payment.shop.licenseclan.LicenseClanShopItemModel;
  import alternativa.tanks.model.payment.shop.lootbox.LootBoxPackage;
  import alternativa.tanks.model.payment.shop.lootbox.LootBoxPackageAdapt;
  import alternativa.tanks.model.payment.shop.lootbox.LootBoxPackageEvents;
  import alternativa.tanks.model.payment.shop.lootbox.LootBoxPackageModel;
  import alternativa.tanks.model.payment.shop.lootboxandpaint.LootboxAndPaintModel;
  import alternativa.tanks.model.payment.shop.notification.ShopNotifierModel;
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotifierService;
  import alternativa.tanks.model.payment.shop.onetimepurchase.EventOneTimePurchaseModel;
  import alternativa.tanks.model.payment.shop.onetimepurchase.ShopItemOneTimePurchase;
  import alternativa.tanks.model.payment.shop.onetimepurchase.ShopItemOneTimePurchaseAdapt;
  import alternativa.tanks.model.payment.shop.onetimepurchase.ShopItemOneTimePurchaseEvents;
  import alternativa.tanks.model.payment.shop.onetimepurchase.ShopItemOneTimePurchaseModel;
  import alternativa.tanks.model.payment.shop.paint.PaintPackage;
  import alternativa.tanks.model.payment.shop.paint.PaintPackageAdapt;
  import alternativa.tanks.model.payment.shop.paint.PaintPackageEvents;
  import alternativa.tanks.model.payment.shop.paint.PaintPackageModel;
  import alternativa.tanks.model.payment.shop.premium.PremiumPackage;
  import alternativa.tanks.model.payment.shop.premium.PremiumPackageAdapt;
  import alternativa.tanks.model.payment.shop.premium.PremiumPackageEvents;
  import alternativa.tanks.model.payment.shop.premium.PremiumPackageModel;
  import alternativa.tanks.model.payment.shop.quantityrestriction.QuantityRestriction;
  import alternativa.tanks.model.payment.shop.quantityrestriction.QuantityRestrictionAdapt;
  import alternativa.tanks.model.payment.shop.quantityrestriction.QuantityRestrictionEvents;
  import alternativa.tanks.model.payment.shop.quantityrestriction.QuantityRestrictionModel;
  import alternativa.tanks.model.payment.shop.renameshopitem.RenameShopItemModel;
  import alternativa.tanks.model.payment.shop.serverlayoutkit.KitBundleViewModel;
  import alternativa.tanks.model.payment.shop.shopabonement.ActiveShopAbonementsModel;
  import alternativa.tanks.model.payment.shop.shopabonement.ShopAbonements;
  import alternativa.tanks.model.payment.shop.shopabonement.ShopAbonementsAdapt;
  import alternativa.tanks.model.payment.shop.shopabonement.ShopAbonementsEvents;
  import alternativa.tanks.model.payment.shop.specialkit.RestrictionByPayModeModel;
  import alternativa.tanks.model.payment.shop.specialkit.SinglePayMode;
  import alternativa.tanks.model.payment.shop.specialkit.SinglePayModeAdapt;
  import alternativa.tanks.model.payment.shop.specialkit.SinglePayModeEvents;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackageAdapt;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackageEvents;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackageModel;
  import alternativa.tanks.model.payment.shop.specialkit.view.NewbieKitViewModel;
  import alternativa.tanks.model.payment.shop.specialkit.view.PayPalKitView;
  import alternativa.tanks.model.payment.shop.specialkit.view.PayPalKitViewAdapt;
  import alternativa.tanks.model.payment.shop.specialkit.view.PayPalKitViewEvents;
  import alternativa.tanks.model.payment.shop.specialkit.view.PayPalKitViewModel;
  import alternativa.tanks.model.payment.shop.specialkit.view.SingleItemKitViewModel;
  import alternativa.tanks.model.personaldiscount.PersonalDiscountModel;
  import alternativa.tanks.model.premiumaccount.alert.PremiumAccountAlertModel;
  import alternativa.tanks.model.premiumaccount.notification.PremiumCompleteNotification;
  import alternativa.tanks.model.presents.NewPresentsShowingModel;
  import alternativa.tanks.model.presents.PresentSettingsModel;
  import alternativa.tanks.model.profile.AndroidRenameModel;
  import alternativa.tanks.model.promo.ShopPromoCode;
  import alternativa.tanks.model.promo.ShopPromoCodeAdapt;
  import alternativa.tanks.model.promo.ShopPromoCodeEvents;
  import alternativa.tanks.model.promo.ShopPromoCodeModel;
  import alternativa.tanks.model.push.FirebasePushNotificationPanelUserProfileModel;
  import alternativa.tanks.model.quest.challenge.ChallengesViewService;
  import alternativa.tanks.model.quest.challenge.gui.ChallengesProgressView;
  import alternativa.tanks.model.quest.challenge.gui.ChallengesTab;
  import alternativa.tanks.model.quest.challenge.gui.ChallengesView;
  import alternativa.tanks.model.quest.challenge.gui.TierNumberView;
  import alternativa.tanks.model.quest.challenge.gui.TierRenderer;
  import alternativa.tanks.model.quest.challenge.rewarding.ChallengesRewardingModel;
  import alternativa.tanks.model.quest.challenge.rewarding.ChallengesRewardingUserModel;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoModel;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoService;
  import alternativa.tanks.model.quest.common.MissionsWindowsService;
  import alternativa.tanks.model.quest.common.gui.CommonQuestTab;
  import alternativa.tanks.model.quest.common.gui.window.QuestItemViewInfoPanel;
  import alternativa.tanks.model.quest.common.gui.window.QuestWindow;
  import alternativa.tanks.model.quest.common.gui.window.buttons.DailyQuestChangeButton;
  import alternativa.tanks.model.quest.common.gui.window.buttons.DailyQuestDisabledPrizeButton;
  import alternativa.tanks.model.quest.common.gui.window.buttons.QuestGetPrizeButton;
  import alternativa.tanks.model.quest.common.gui.window.navigatepanel.QuestTabButton;
  import alternativa.tanks.model.quest.common.gui.window.navigatepanel.QuestTabButtonsList;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierModel;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierService;
  import alternativa.tanks.model.quest.daily.DailyQuestShowingModel;
  import alternativa.tanks.model.quest.daily.DailyQuestsService;
  import alternativa.tanks.model.quest.daily.gui.DailyQuestItemView;
  import alternativa.tanks.model.quest.daily.gui.DailyQuestTab;
  import alternativa.tanks.model.quest.weekly.WeeklyQuestShowingModel;
  import alternativa.tanks.model.quest.weekly.WeeklyQuestsService;
  import alternativa.tanks.model.quest.weekly.gui.WeeklyQuestTab;
  import alternativa.tanks.model.rankupbonus.RankUpBonusAlertModel;
  import alternativa.tanks.model.referrals.ReferralsModel;
  import alternativa.tanks.model.referrals.notifier.NewReferralsNotifierModel;
  import alternativa.tanks.model.rulesupdate.RulesUpdateShowingModel;
  import alternativa.tanks.model.settings.SettingsModel;
  import alternativa.tanks.model.socialnetwork.SocialNetworkPanelModel;
  import alternativa.tanks.model.socialnetwork.notification.SNGroupReminderModel;
  import alternativa.tanks.model.tutorialhints.TutorialHintsModel;
  import alternativa.tanks.model.usercountry.UserCountryModel;
  import alternativa.tanks.model.useremailandpassword.IUserEmailAndPassword;
  import alternativa.tanks.model.useremailandpassword.IUserEmailAndPasswordAdapt;
  import alternativa.tanks.model.useremailandpassword.IUserEmailAndPasswordEvents;
  import alternativa.tanks.model.useremailandpassword.PasswordService;
  import alternativa.tanks.model.useremailandpassword.PasswordServiceAdapt;
  import alternativa.tanks.model.useremailandpassword.PasswordServiceEvents;
  import alternativa.tanks.model.useremailandpassword.UserEmailAndPasswordModel;
  import alternativa.tanks.model.userproperties.IUserProperties;
  import alternativa.tanks.model.userproperties.IUserPropertiesAdapt;
  import alternativa.tanks.model.userproperties.IUserPropertiesEvents;
  import alternativa.tanks.model.userproperties.UserPropertiesModel;
  import alternativa.tanks.model.userscounter.UsersCounterModel;
  import alternativa.tanks.model.videoadvertisement.VideoAdsBattleResultModel;
  import alternativa.tanks.model.videoadvertisement.VideoAdsModel;
  import alternativa.tanks.newbieservice.NewbieUserService;
  import alternativa.tanks.service.achievement.AchievementService;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.battlelinkactivator.BattleLinkActivatorService;
  import alternativa.tanks.service.clan.ClanFriendsService;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import alternativa.tanks.service.country.CountryService;
  import alternativa.tanks.service.fps.FPSService;
  import alternativa.tanks.service.fps.FPSServiceImpl;
  import alternativa.tanks.service.logging.UserChangeGameScreenServiceImpl;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.tanks.service.money.MoneyService;
  import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
  import alternativa.tanks.service.notificationcategories.NotificationGarageCategoriesService;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.panel.PanelView;
  import alternativa.tanks.service.payment.IPaymentPackagesService;
  import alternativa.tanks.service.payment.IPaymentService;
  import alternativa.tanks.service.payment.PaymentService;
  import alternativa.tanks.service.payment.display.PaymentDisplayServiceImpl;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteService;
  import alternativa.tanks.service.referrals.ReferralsService;
  import alternativa.tanks.service.referrals.buttonhelper.ReferralsButtonHelperService;
  import alternativa.tanks.service.referrals.buttonhelper.ReferralsButtonHelperServiceImpl;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingsService;
  import alternativa.tanks.service.settings.keybinding.KeyCodesConverter;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.service.socialnetwork.ISocialNetworkPanelService;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsService;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsServiceImpl;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsServiceImpl;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.models.challenge.shopitems.ChallengeShopItems;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.notification.sound.INotificationSoundService;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.buttonbar.IButtonBarService;
  import services.contextmenu.IContextMenuService;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegister:ModelRegistry;
      var modelRegisterAdapt:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(IPaymentPackagesService,function(param1:Object):void {
        ExchangeCalculator.paymentPackagesService = IPaymentPackagesService(param1);
      },function():IPaymentPackagesService {
        return ExchangeCalculator.paymentPackagesService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        ExchangeCalculator.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return ExchangeCalculator.paymentService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AntiAddictionWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AntiAddictionWindow.localeService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        AvailableItemsAlert.premiumService = PremiumService(param1);
      },function():PremiumService {
        return AvailableItemsAlert.premiumService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CongratulationsWindowConfiscate.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CongratulationsWindowConfiscate.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CongratulationsWindowPresent.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CongratulationsWindowPresent.localeService;
      });
      osgi.injectService(NewbieUserService,function(param1:Object):void {
        CongratulationsWindowPresent.newbieUserService = NewbieUserService(param1);
      },function():NewbieUserService {
        return CongratulationsWindowPresent.newbieUserService;
      });
      osgi.injectService(YandexMetricaService,function(param1:Object):void {
        CongratulationsWindowPresent.ymService = YandexMetricaService(param1);
      },function():YandexMetricaService {
        return CongratulationsWindowPresent.ymService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CongratulationsWindowWithBanner.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CongratulationsWindowWithBanner.localeService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        EmailBlock.displayService = IDisplay(param1);
      },function():IDisplay {
        return EmailBlock.displayService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EmailBlock.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EmailBlock.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        EmailBlock.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return EmailBlock.userPropertyService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        EmailBlock.validateService = IValidateService(param1);
      },function():IValidateService {
        return EmailBlock.validateService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EmailReminderWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EmailReminderWindow.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EntranceAlertWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EntranceAlertWindow.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RankUpSupplyBonusAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RankUpSupplyBonusAlert.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RepatriateBonusWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RepatriateBonusWindow.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RulesUpdateAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RulesUpdateAlert.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ThanksForPurchaseWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ThanksForPurchaseWindow.localeService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        ThanksForPurchaseWindow.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return ThanksForPurchaseWindow.paymentDisplayService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ItemsAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ItemsAlert.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        ItemsAlert.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return ItemsAlert.modalLoaderService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RankUpBonusAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RankUpBonusAlert.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        RankUpBonusAlert.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return RankUpBonusAlert.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleFinishNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleFinishNotification.localeService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BuyCrystalsAlert.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BuyCrystalsAlert.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BuyCrystalsAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BuyCrystalsAlert.localeService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        BuyCrystalsAlert.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return BuyCrystalsAlert.paymentDisplayService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        CrystalButton.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return CrystalButton.moneyService;
      });
      osgi.injectService(FPSService,function(param1:Object):void {
        BlinkEffect.fpsService = FPSService(param1);
      },function():FPSService {
        return BlinkEffect.fpsService;
      });
      osgi.injectService(FPSService,function(param1:Object):void {
        FlashEffect.fpsService = FPSService(param1);
      },function():FPSService {
        return FlashEffect.fpsService;
      });
      osgi.injectService(FPSService,function(param1:Object):void {
        GlowEffect.fpsService = FPSService(param1);
      },function():FPSService {
        return GlowEffect.fpsService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        ErrorForm.addressService = AddressService(param1);
      },function():AddressService {
        return ErrorForm.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        ErrorNotification.addressService = AddressService(param1);
      },function():AddressService {
        return ErrorNotification.addressService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ErrorNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ErrorNotification.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        AddRequestView.alertService = IAlertService(param1);
      },function():IAlertService {
        return AddRequestView.alertService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        AddRequestView.blurService = IBlurService(param1);
      },function():IBlurService {
        return AddRequestView.blurService;
      });
      osgi.injectService(IFriendActionService,function(param1:Object):void {
        AddRequestView.friendsActionService = IFriendActionService(param1);
      },function():IFriendActionService {
        return AddRequestView.friendsActionService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AddRequestView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AddRequestView.localeService;
      });
      osgi.injectService(UidCheckService,function(param1:Object):void {
        AddRequestView.uidCheckService = UidCheckService(param1);
      },function():UidCheckService {
        return AddRequestView.uidCheckService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        AddRequestView.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return AddRequestView.userPropertiesService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        FriendsWindow.alertService = IAlertService(param1);
      },function():IAlertService {
        return FriendsWindow.alertService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        FriendsWindow.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return FriendsWindow.battleLinkActivatorService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        FriendsWindow.blurService = IBlurService(param1);
      },function():IBlurService {
        return FriendsWindow.blurService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        FriendsWindow.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return FriendsWindow.clanUserInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsWindow.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsWindow.friendInfoService;
      });
      osgi.injectService(IFriendActionService,function(param1:Object):void {
        FriendsWindow.friendsActionService = IFriendActionService(param1);
      },function():IFriendActionService {
        return FriendsWindow.friendsActionService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FriendsWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FriendsWindow.localeService;
      });
      osgi.injectService(NewReferralsNotifierService,function(param1:Object):void {
        FriendsWindow.newReferralsNotifierService = NewReferralsNotifierService(param1);
      },function():NewReferralsNotifierService {
        return FriendsWindow.newReferralsNotifierService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        FriendsWindow.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return FriendsWindow.partnerService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        FriendsWindow.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return FriendsWindow.userChangeGameScreenService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        FriendsWindow.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return FriendsWindow.userInfoService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        BattleLink.addressService = AddressService(param1);
      },function():AddressService {
        return BattleLink.addressService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleLink.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleLink.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleLink.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleLink.localeService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        BattleLink.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return BattleLink.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleLink.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleLink.userPropertiesService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleInviteNotification.battleAlertService = IAlertService(param1);
      },function():IAlertService {
        return BattleInviteNotification.battleAlertService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        BattleInviteNotification.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return BattleInviteNotification.battleInviteService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        BattleInviteNotification.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return BattleInviteNotification.dialogWindowsDispatcherService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleInviteNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleInviteNotification.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BattleInviteNotification.storageService = IStorageService(param1);
      },function():IStorageService {
        return BattleInviteNotification.storageService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        NewRequestIndicator.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return NewRequestIndicator.friendInfoService;
      });
      osgi.injectService(NewReferralsNotifierService,function(param1:Object):void {
        NewRequestIndicator.newReferralsNotifierService = NewReferralsNotifierService(param1);
      },function():NewReferralsNotifierService {
        return NewRequestIndicator.newReferralsNotifierService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        RequestCountIndicator.display = IDisplay(param1);
      },function():IDisplay {
        return RequestCountIndicator.display;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        RequestCountIndicator.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return RequestCountIndicator.friendInfoService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        AcceptedList.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return AcceptedList.battleInfoService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        AcceptedList.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return AcceptedList.battleInviteService;
      });
      osgi.injectService(IBattleNotifierService,function(param1:Object):void {
        AcceptedList.battleNotifierService = IBattleNotifierService(param1);
      },function():IBattleNotifierService {
        return AcceptedList.battleNotifierService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        AcceptedList.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return AcceptedList.contextMenuService;
      });
      osgi.injectService(IOnlineNotifierService,function(param1:Object):void {
        AcceptedList.onlineNotifierService = IOnlineNotifierService(param1);
      },function():IOnlineNotifierService {
        return AcceptedList.onlineNotifierService;
      });
      osgi.injectService(SNFriendsService,function(param1:Object):void {
        AcceptedList.snFriendsService = SNFriendsService(param1);
      },function():SNFriendsService {
        return AcceptedList.snFriendsService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ClanMembersList.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ClanMembersList.battleInfoService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        ClanMembersList.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return ClanMembersList.battleInviteService;
      });
      osgi.injectService(IBattleNotifierService,function(param1:Object):void {
        ClanMembersList.battleNotifierService = IBattleNotifierService(param1);
      },function():IBattleNotifierService {
        return ClanMembersList.battleNotifierService;
      });
      osgi.injectService(ClanFriendsService,function(param1:Object):void {
        ClanMembersList.clanFriendsService = ClanFriendsService(param1);
      },function():ClanFriendsService {
        return ClanMembersList.clanFriendsService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        ClanMembersList.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return ClanMembersList.contextMenuService;
      });
      osgi.injectService(IOnlineNotifierService,function(param1:Object):void {
        ClanMembersList.onlineNotifierService = IOnlineNotifierService(param1);
      },function():IOnlineNotifierService {
        return ClanMembersList.onlineNotifierService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        ClanMembersList.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return ClanMembersList.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ClanMembersList.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ClanMembersList.userPropertiesService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsList.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsList.friendInfoService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        FriendsList.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return FriendsList.userInfoService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        IncomingList.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return IncomingList.contextMenuService;
      });
      osgi.injectService(IFriendActionService,function(param1:Object):void {
        IncomingList.friendActionService = IFriendActionService(param1);
      },function():IFriendActionService {
        return IncomingList.friendActionService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        IncomingList.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return IncomingList.friendInfoService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        FriendsDataProvider.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return FriendsDataProvider.battleInfoService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsDataProvider.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsDataProvider.friendInfoService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        FriendsDataProvider.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return FriendsDataProvider.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        FriendsDataProvider.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return FriendsDataProvider.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ReferralForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ReferralForm.localeService;
      });
      osgi.injectService(NewReferralsNotifierService,function(param1:Object):void {
        ReferralForm.newReferralsNotifierService = NewReferralsNotifierService(param1);
      },function():NewReferralsNotifierService {
        return ReferralForm.newReferralsNotifierService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        ReferralForm.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return ReferralForm.partnerService;
      });
      osgi.injectService(ReferralsService,function(param1:Object):void {
        ReferralForm.referralService = ReferralsService(param1);
      },function():ReferralsService {
        return ReferralForm.referralService;
      });
      osgi.injectService(ReferralsButtonHelperService,function(param1:Object):void {
        ReferralForm.referralsButtonHelperService = ReferralsButtonHelperService(param1);
      },function():ReferralsButtonHelperService {
        return ReferralForm.referralsButtonHelperService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ReferralStatHeader.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ReferralStatHeader.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LinkReferralButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LinkReferralButton.localeService;
      });
      osgi.injectService(ReferralsService,function(param1:Object):void {
        LinkReferralButton.referralService = ReferralsService(param1);
      },function():ReferralsService {
        return LinkReferralButton.referralService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        OkReferralButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return OkReferralButton.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        OkReferralButton.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return OkReferralButton.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        VkReferralButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return VkReferralButton.localeService;
      });
      osgi.injectService(ReferralsService,function(param1:Object):void {
        VkReferralButton.referralService = ReferralsService(param1);
      },function():ReferralsService {
        return VkReferralButton.referralService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        VkReferralButton.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return VkReferralButton.userPropertiesService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ClanMembersListRenderer.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ClanMembersListRenderer.battleInfoService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        ClanMembersListRenderer.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return ClanMembersListRenderer.battleLinkActivatorService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        ClanMembersListRenderer.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return ClanMembersListRenderer.contextMenuService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ClanMembersListRenderer.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ClanMembersListRenderer.localeService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        FriendsAcceptedListRenderer.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return FriendsAcceptedListRenderer.battleInfoService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        FriendsAcceptedListRenderer.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return FriendsAcceptedListRenderer.battleLinkActivatorService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        FriendsAcceptedListRenderer.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return FriendsAcceptedListRenderer.contextMenuService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FriendsAcceptedListRenderer.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FriendsAcceptedListRenderer.localeService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        FriendsIncomingListRenderer.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return FriendsIncomingListRenderer.contextMenuService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FriendsIncomingListRenderer.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FriendsIncomingListRenderer.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        HeaderAcceptedList.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return HeaderAcceptedList.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        HeaderAcceptedList.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return HeaderAcceptedList.partnersService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        PartsListRenderer.clientLog = IClientLog(param1);
      },function():IClientLog {
        return PartsListRenderer.clientLog;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        NewbiesAbonementInfoWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return NewbiesAbonementInfoWindow.localeService;
      });
      osgi.injectService(NewbieUserService,function(param1:Object):void {
        NewbiesAbonementInfoWindow.newbieUserService = NewbieUserService(param1);
      },function():NewbieUserService {
        return NewbiesAbonementInfoWindow.newbieUserService;
      });
      osgi.injectService(IButtonBarService,function(param1:Object):void {
        ButtonBar.buttonBarService = IButtonBarService(param1);
      },function():IButtonBarService {
        return ButtonBar.buttonBarService;
      });
      osgi.injectService(ClanPanelNotificationService,function(param1:Object):void {
        ButtonBar.clanPanelNotificationService = ClanPanelNotificationService(param1);
      },function():ClanPanelNotificationService {
        return ButtonBar.clanPanelNotificationService;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        ButtonBar.fullscreenService = FullscreenService(param1);
      },function():FullscreenService {
        return ButtonBar.fullscreenService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ButtonBar.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ButtonBar.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ButtonBar.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ButtonBar.userPropertiesService;
      });
      osgi.injectService(BattlePassPurchaseService,function(param1:Object):void {
        MainPanel.battlePassPurchaseService = BattlePassPurchaseService(param1);
      },function():BattlePassPurchaseService {
        return MainPanel.battlePassPurchaseService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        MainPanel.challengeInfoService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return MainPanel.challengeInfoService;
      });
      osgi.injectService(ClanPanelNotificationService,function(param1:Object):void {
        MainPanel.clanPanelNotification = ClanPanelNotificationService(param1);
      },function():ClanPanelNotificationService {
        return MainPanel.clanPanelNotification;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        MainPanel.display = IDisplay(param1);
      },function():IDisplay {
        return MainPanel.display;
      });
      osgi.injectService(MissionsWindowsService,function(param1:Object):void {
        MainPanel.missionsWindowsService = MissionsWindowsService(param1);
      },function():MissionsWindowsService {
        return MainPanel.missionsWindowsService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        MainPanel.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return MainPanel.partnerService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        MainPanel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return MainPanel.paymentDisplayService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        MainPanel.premiumService = PremiumService(param1);
      },function():PremiumService {
        return MainPanel.premiumService;
      });
      osgi.injectService(ReconnectService,function(param1:Object):void {
        MainPanel.reconnectService = ReconnectService(param1);
      },function():ReconnectService {
        return MainPanel.reconnectService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        MainPanel.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return MainPanel.userChangeGameScreenService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        MainPanel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return MainPanel.userPropertiesService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        PlayerInfo.rankService = RankService(param1);
      },function():RankService {
        return PlayerInfo.rankService;
      });
      osgi.injectService(StarsInfoService,function(param1:Object):void {
        StarsCashLabel.starsInfoService = StarsInfoService(param1);
      },function():StarsInfoService {
        return StarsCashLabel.starsInfoService;
      });
      osgi.injectService(ClanPanelNotificationService,function(param1:Object):void {
        ClanButton.clanPanelNotificationService = ClanPanelNotificationService(param1);
      },function():ClanPanelNotificationService {
        return ClanButton.clanPanelNotificationService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        ClanButton.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return ClanButton.clanUserInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ClanButton.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ClanButton.lobbyLayoutService;
      });
      osgi.injectService(QuestNotifierService,function(param1:Object):void {
        QuestsButton.questNotifierService = QuestNotifierService(param1);
      },function():QuestNotifierService {
        return QuestsButton.questNotifierService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BonusLabel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BonusLabel.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PremiumLabel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PremiumLabel.localeService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        ExchangeGroup.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return ExchangeGroup.achievementService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        ExchangeGroup.helperService = IHelpService(param1);
      },function():IHelpService {
        return ExchangeGroup.helperService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ExchangeGroup.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ExchangeGroup.localeService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        ExchangeGroup.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return ExchangeGroup.paymentService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        PayModeForm.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return PayModeForm.paymentWindowService;
      });
      osgi.injectService(UserPaymentActionsService,function(param1:Object):void {
        PayModeForm.userPaymentActionsService = UserPaymentActionsService(param1);
      },function():UserPaymentActionsService {
        return PayModeForm.userPaymentActionsService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        Gate2ShopForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return Gate2ShopForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LeogamingCodeConfirmForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LeogamingCodeConfirmForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LeogamingMobileForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LeogamingMobileForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LeogamingPhoneForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LeogamingPhoneForm.localeService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PhoneNumberInput.displayService = IDisplay(param1);
      },function():IDisplay {
        return PhoneNumberInput.displayService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PlatBoxForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PlatBoxForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PlatboxPhoneNumberForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PlatboxPhoneNumberForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        QiwiPhoneNumberForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return QiwiPhoneNumberForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PersonalDiscountAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PersonalDiscountAlert.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        PersonalDiscountAlert.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return PersonalDiscountAlert.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PremiumAccountWelcomeAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PremiumAccountWelcomeAlert.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        NewPresentsAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return NewPresentsAlert.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        NewPresentsAlert.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return NewPresentsAlert.modalLoaderService;
      });
      osgi.injectService(CountryService,function(param1:Object):void {
        SelectCountryAlert.countryService = CountryService(param1);
      },function():CountryService {
        return SelectCountryAlert.countryService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        SelectCountryAlert.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return SelectCountryAlert.dialogService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SelectCountryAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SelectCountryAlert.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SettingsTabButtonList.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SettingsTabButtonList.localeService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        SettingsWindow.helperService = IHelpService(param1);
      },function():IHelpService {
        return SettingsWindow.helperService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SettingsWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SettingsWindow.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        SettingsWindow.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return SettingsWindow.partnersService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        SettingsWindow.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return SettingsWindow.userChangeGameScreenService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SettingsTabView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SettingsTabView.localeService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        SettingsTabView.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return SettingsTabView.settingsService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        SoundSettingsTab.display = IDisplay(param1);
      },function():IDisplay {
        return SoundSettingsTab.display;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        AccountSettingsTab.display = IDisplay(param1);
      },function():IDisplay {
        return AccountSettingsTab.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        AccountSettingsTab.helperService = IHelpService(param1);
      },function():IHelpService {
        return AccountSettingsTab.helperService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        AccountSettingsTab.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return AccountSettingsTab.partnersService;
      });
      osgi.injectService(ISocialNetworkPanelService,function(param1:Object):void {
        AccountSettingsTab.socialNetworkService = ISocialNetworkPanelService(param1);
      },function():ISocialNetworkPanelService {
        return AccountSettingsTab.socialNetworkService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        AccountSettingsTab.validateService = IValidateService(param1);
      },function():IValidateService {
        return AccountSettingsTab.validateService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ControlSettingsTab.display = IDisplay(param1);
      },function():IDisplay {
        return ControlSettingsTab.display;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        ControlSettingsTab.fullScreenService = FullscreenService(param1);
      },function():FullscreenService {
        return ControlSettingsTab.fullScreenService;
      });
      osgi.injectService(KeysBindingService,function(param1:Object):void {
        KeyBinding.keysBindingService = KeysBindingService(param1);
      },function():KeysBindingService {
        return KeyBinding.keysBindingService;
      });
      osgi.injectService(KeysBindingService,function(param1:Object):void {
        KeyBindingsPanel.keysBindingService = KeysBindingService(param1);
      },function():KeysBindingService {
        return KeyBindingsPanel.keysBindingService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        KeyBindingsPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return KeyBindingsPanel.localeService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        GameSettingsTab.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return GameSettingsTab.battleInviteService;
      });
      osgi.injectService(ShopNotifierService,function(param1:Object):void {
        ShopNotificationIndicator.shopNotifierService = ShopNotifierService(param1);
      },function():ShopNotifierService {
        return ShopNotificationIndicator.shopNotifierService;
      });
      osgi.injectService(CountryService,function(param1:Object):void {
        ShopWindowCountrySelector.countryService = CountryService(param1);
      },function():CountryService {
        return ShopWindowCountrySelector.countryService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ShopWindowCountrySelector.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ShopWindowCountrySelector.localeService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        ShopWindowCountrySelector.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return ShopWindowCountrySelector.paymentDisplayService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ShopWindowNavigationBar.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ShopWindowNavigationBar.localeService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        ShopWindowNavigationBar.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return ShopWindowNavigationBar.paymentService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        ShopWindowNavigationBar.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return ShopWindowNavigationBar.paymentWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ApproveOneTimePurchaseForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ApproveOneTimePurchaseForm.localeService;
      });
      osgi.injectService(CountryService,function(param1:Object):void {
        SMSForm.countryService = CountryService(param1);
      },function():CountryService {
        return SMSForm.countryService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SMSForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SMSForm.localeService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        SMSForm.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return SMSForm.paymentService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        SMSForm.storageService = IStorageService(param1);
      },function():IStorageService {
        return SMSForm.storageService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        WaitUrlForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return WaitUrlForm.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PayModeChooseView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PayModeChooseView.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PaymentFormOneTimePurchaseView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PaymentFormOneTimePurchaseView.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PaymentFormView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PaymentFormView.localeService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PromoCodeActivateForm.display = IDisplay(param1);
      },function():IDisplay {
        return PromoCodeActivateForm.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PromoCodeActivateForm.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PromoCodeActivateForm.localeService;
      });
      osgi.injectService(IValidateService,function(param1:Object):void {
        PromoCodeActivateForm.validateService = IValidateService(param1);
      },function():IValidateService {
        return PromoCodeActivateForm.validateService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        GoodsChooseView.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return GoodsChooseView.paymentWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        OtherShopItemButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return OtherShopItemButton.localeService;
      });
      osgi.injectService(TanksFontsFormatService,function(param1:Object):void {
        ShopItemButton.fontService = TanksFontsFormatService(param1);
      },function():TanksFontsFormatService {
        return ShopItemButton.fontService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ShopItemButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ShopItemButton.localeService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        ShopItemButton.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return ShopItemButton.paymentWindowService;
      });
      osgi.injectService(ITimeUnitService,function(param1:Object):void {
        ShopItemButton.timeUnitService = ITimeUnitService(param1);
      },function():ITimeUnitService {
        return ShopItemButton.timeUnitService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        CashPackageButton.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return CashPackageButton.paymentWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        KitPackageDescriptionView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return KitPackageDescriptionView.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LicenseClanButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LicenseClanButton.localeService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        ShopWindow.blurService = IBlurService(param1);
      },function():IBlurService {
        return ShopWindow.blurService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        ShopWindow.clientLog = IClientLog(param1);
      },function():IClientLog {
        return ShopWindow.clientLog;
      });
      osgi.injectService(CoinInfoService,function(param1:Object):void {
        ShopWindow.coinInfoService = CoinInfoService(param1);
      },function():CoinInfoService {
        return ShopWindow.coinInfoService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        ShopWindow.dialogsService = IDialogsService(param1);
      },function():IDialogsService {
        return ShopWindow.dialogsService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ShopWindow.display = IDisplay(param1);
      },function():IDisplay {
        return ShopWindow.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ShopWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ShopWindow.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        ShopWindow.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return ShopWindow.partnerService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        ShopWindow.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return ShopWindow.paymentDisplayService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        ShopWindow.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return ShopWindow.settingsService;
      });
      osgi.injectService(ShopNotifierService,function(param1:Object):void {
        ShopWindow.shopNotifierService = ShopNotifierService(param1);
      },function():ShopNotifierService {
        return ShopWindow.shopNotifierService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        ShopWindow.storageService = IStorageService(param1);
      },function():IStorageService {
        return ShopWindow.storageService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        ShopWindow.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return ShopWindow.trackerService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ShopWindow.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ShopWindow.userPropertyService;
      });
      osgi.injectService(EmailReminderService,function(param1:Object):void {
        PaymentBugReportBlock.emailReminderService = EmailReminderService(param1);
      },function():EmailReminderService {
        return PaymentBugReportBlock.emailReminderService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PaymentBugReportBlock.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PaymentBugReportBlock.localeService;
      });
      osgi.injectService(ProcessedPaymentService,function(param1:Object):void {
        PaymentBugReportBlock.processedPaymentService = ProcessedPaymentService(param1);
      },function():ProcessedPaymentService {
        return PaymentBugReportBlock.processedPaymentService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        PaymentBugReportBlock.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return PaymentBugReportBlock.settingsService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        PaymentBugReportBlock.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return PaymentBugReportBlock.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AbstractSNGroupEnteringWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AbstractSNGroupEnteringWindow.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DateTimeHelper.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DateTimeHelper.localeService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        AchievementModel.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return AchievementModel.achievementService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        AntiAddictionAlertModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return AntiAddictionAlertModel.panelView;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BonusImageShowingModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BonusImageShowingModel.lobbyLayoutService;
      });
      osgi.injectService(ChallengeShopItems,function(param1:Object):void {
        ChallengeShopItemsModel.challengeShopItems = ChallengeShopItems(param1);
      },function():ChallengeShopItems {
        return ChallengeShopItemsModel.challengeShopItems;
      });
      osgi.injectService(BattlePassPurchaseService,function(param1:Object):void {
        BattlePassPurchaseNotifierModel.battlePassPurchaseService = BattlePassPurchaseService(param1);
      },function():BattlePassPurchaseService {
        return BattlePassPurchaseNotifierModel.battlePassPurchaseService;
      });
      osgi.injectService(CoinInfoService,function(param1:Object):void {
        CoinInfoModel.coinInfoService = CoinInfoService(param1);
      },function():CoinInfoService {
        return CoinInfoModel.coinInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DonationAlertModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DonationAlertModel.lobbyLayoutService;
      });
      osgi.injectService(PaymentCompleteService,function(param1:Object):void {
        DonationAlertModel.paymentCompleteService = PaymentCompleteService(param1);
      },function():PaymentCompleteService {
        return DonationAlertModel.paymentCompleteService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        DonationAlertModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return DonationAlertModel.settingsService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        EmailReminderModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return EmailReminderModel.panelView;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        EmailReminderModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return EmailReminderModel.settingsService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleInviteModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return BattleInviteModel.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleInviteModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleInviteModel.battleInfoService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        BattleInviteModel.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return BattleInviteModel.battleInviteService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        BattleInviteModel.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return BattleInviteModel.battleLinkActivatorService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        BattleInviteModel.blurService = IBlurService(param1);
      },function():IBlurService {
        return BattleInviteModel.blurService;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        BattleInviteModel.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return BattleInviteModel.friendInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleInviteModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleInviteModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleInviteModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleInviteModel.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        BattleInviteModel.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return BattleInviteModel.modalLoaderService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        BattleInviteModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return BattleInviteModel.notificationService;
      });
      osgi.injectService(INotificationSoundService,function(param1:Object):void {
        BattleInviteModel.notificationSoundService = INotificationSoundService(param1);
      },function():INotificationSoundService {
        return BattleInviteModel.notificationSoundService;
      });
      osgi.injectService(ReconnectService,function(param1:Object):void {
        BattleInviteModel.reconnectService = ReconnectService(param1);
      },function():ReconnectService {
        return BattleInviteModel.reconnectService;
      });
      osgi.injectService(ServerNumberToLocaleServerService,function(param1:Object):void {
        BattleInviteModel.serverNameService = ServerNumberToLocaleServerService(param1);
      },function():ServerNumberToLocaleServerService {
        return BattleInviteModel.serverNameService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        BattleInviteModel.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return BattleInviteModel.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleInviteModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleInviteModel.userPropertiesService;
      });
      osgi.injectService(IButtonBarService,function(param1:Object):void {
        FriendsLoaderModel.buttonBarService = IButtonBarService(param1);
      },function():IButtonBarService {
        return FriendsLoaderModel.buttonBarService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        FriendsLoaderModel.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return FriendsLoaderModel.clanUserInfoService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        FriendsLoaderModel.display = IDisplay(param1);
      },function():IDisplay {
        return FriendsLoaderModel.display;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        FriendsLoaderModel.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return FriendsLoaderModel.friendInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        AvailableItemsModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return AvailableItemsModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AvailableItemsModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AvailableItemsModel.localeService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        AvailableItemsModel.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return AvailableItemsModel.modalLoaderService;
      });
      osgi.injectService(INotificationGarageCategoriesService,function(param1:Object):void {
        AvailableItemsModel.notificationGarageCategoriesService = INotificationGarageCategoriesService(param1);
      },function():INotificationGarageCategoriesService {
        return AvailableItemsModel.notificationGarageCategoriesService;
      });
      osgi.injectService(UpgradingItemsService,function(param1:Object):void {
        UpgradingItemsModel.upgradingItemsService = UpgradingItemsService(param1);
      },function():UpgradingItemsService {
        return UpgradingItemsModel.upgradingItemsService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        KitOfferDialog.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return KitOfferDialog.loaderWindowService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        KitOfferDialog.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return KitOfferDialog.localeService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        KitOfferDialog.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return KitOfferDialog.paymentDisplayService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        KitOfferModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return KitOfferModel.paymentDisplayService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        NewbiesAbonementShowInfoModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return NewbiesAbonementShowInfoModel.lobbyLayoutService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        PanelModel.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return PanelModel.achievementService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        PanelModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return PanelModel.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        PanelModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return PanelModel.battleInfoService;
      });
      osgi.injectService(ClanPanelNotificationService,function(param1:Object):void {
        PanelModel.clanPanelNotificationService = ClanPanelNotificationService(param1);
      },function():ClanPanelNotificationService {
        return PanelModel.clanPanelNotificationService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        PanelModel.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return PanelModel.clanUserInfoService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        PanelModel.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return PanelModel.dialogWindowsDispatcherService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PanelModel.display = IDisplay(param1);
      },function():IDisplay {
        return PanelModel.display;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        PanelModel.fullscreenService = FullscreenService(param1);
      },function():FullscreenService {
        return PanelModel.fullscreenService;
      });
      osgi.injectService(FullscreenStateService,function(param1:Object):void {
        PanelModel.fullscreenStateService = FullscreenStateService(param1);
      },function():FullscreenStateService {
        return PanelModel.fullscreenStateService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        PanelModel.helpService = IHelpService(param1);
      },function():IHelpService {
        return PanelModel.helpService;
      });
      osgi.injectService(KeysBindingService,function(param1:Object):void {
        PanelModel.keysBindingService = KeysBindingService(param1);
      },function():KeysBindingService {
        return PanelModel.keysBindingService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        PanelModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return PanelModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PanelModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PanelModel.localeService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        PanelModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return PanelModel.panelView;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        PanelModel.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return PanelModel.partnerService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        PanelModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return PanelModel.paymentDisplayService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        PanelModel.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return PanelModel.paymentService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        PanelModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return PanelModel.trackerService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        PanelModel.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return PanelModel.userChangeGameScreenService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        PanelModel.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return PanelModel.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        PanelModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return PanelModel.userPropertiesService;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        PaymentButtonModel.launchParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return PaymentButtonModel.launchParams;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        PaymentButtonModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return PaymentButtonModel.panelView;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        PaymentButtonModel.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return PaymentButtonModel.paymentService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        PaymentLoaderModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return PaymentLoaderModel.paymentDisplayService;
      });
      osgi.injectService(IPaymentPackagesService,function(param1:Object):void {
        CrystalsPaymentModel.paymentPackagesService = IPaymentPackagesService(param1);
      },function():IPaymentPackagesService {
        return CrystalsPaymentModel.paymentPackagesService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        CrystalsPaymentModel.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return CrystalsPaymentModel.paymentService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        CrystalsPaymentModel.paymentWindow = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return CrystalsPaymentModel.paymentWindow;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        PaymentModel.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return PaymentModel.achievementService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        PaymentModel.blurService = IBlurService(param1);
      },function():IBlurService {
        return PaymentModel.blurService;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        PaymentModel.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return PaymentModel.loaderWindowService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        PaymentModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return PaymentModel.paymentDisplayService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        PaymentModel.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return PaymentModel.paymentService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        PaymentModel.paymentWindow = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return PaymentModel.paymentWindow;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        PaymentModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return PaymentModel.trackerService;
      });
      osgi.injectService(UserPaymentActionsService,function(param1:Object):void {
        PaymentModel.userPaymentActionService = UserPaymentActionsService(param1);
      },function():UserPaymentActionsService {
        return PaymentModel.userPaymentActionService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        PaymentModeModel.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return PaymentModeModel.partnersService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        PaymentModeModel.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return PaymentModeModel.paymentService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        PaymentModeModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return PaymentModeModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        AlipayPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return AlipayPaymentModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        AsyncUrlPayModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return AsyncUrlPayModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        BraintreePaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return BraintreePaymentModel.paymentWindowService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        PayModeBottomDescriptionModel.clientLog = IClientLog(param1);
      },function():IClientLog {
        return PayModeBottomDescriptionModel.clientLog;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        ErrorsDescriptionModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return ErrorsDescriptionModel.alertService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        Gate2ShopPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return Gate2ShopPaymentModel.paymentWindowService;
      });
      osgi.injectService(PaymentCompleteService,function(param1:Object):void {
        LeogamingPaymentMobileModel.paymentCompleteService = PaymentCompleteService(param1);
      },function():PaymentCompleteService {
        return LeogamingPaymentMobileModel.paymentCompleteService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        LeogamingPaymentMobileModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return LeogamingPaymentMobileModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        OnlyUrlPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return OnlyUrlPaymentModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        PayGardenPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return PayGardenPaymentModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        PayPalPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return PayPalPaymentModel.paymentWindowService;
      });
      osgi.injectService(PaymentCompleteService,function(param1:Object):void {
        PlatBoxPaymentModel.paymentCompleteService = PaymentCompleteService(param1);
      },function():PaymentCompleteService {
        return PlatBoxPaymentModel.paymentCompleteService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        PlatBoxPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return PlatBoxPaymentModel.paymentWindowService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        QiwiPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return QiwiPaymentModel.paymentWindowService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        SMSPayModeModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return SMSPayModeModel.storageService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        GoToUrlPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return GoToUrlPaymentModel.paymentWindowService;
      });
      osgi.injectService(EmailReminderService,function(param1:Object):void {
        PaymentWindowServiceImpl.emailReminderService = EmailReminderService(param1);
      },function():EmailReminderService {
        return PaymentWindowServiceImpl.emailReminderService;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        PaymentWindowServiceImpl.fullscreenService = FullscreenService(param1);
      },function():FullscreenService {
        return PaymentWindowServiceImpl.fullscreenService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PaymentWindowServiceImpl.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PaymentWindowServiceImpl.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        PaymentWindowServiceImpl.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return PaymentWindowServiceImpl.partnerService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        PaymentWindowServiceImpl.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return PaymentWindowServiceImpl.paymentDisplayService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        PaymentWindowServiceImpl.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return PaymentWindowServiceImpl.settingsService;
      });
      osgi.injectService(UserPaymentActionsService,function(param1:Object):void {
        PaymentWindowServiceImpl.userPaymentActionsService = UserPaymentActionsService(param1);
      },function():UserPaymentActionsService {
        return PaymentWindowServiceImpl.userPaymentActionsService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        ProcessedPaymentServiceImp.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return ProcessedPaymentServiceImp.paymentWindowService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        ProcessedPaymentServiceImp.storageService = IStorageService(param1);
      },function():IStorageService {
        return ProcessedPaymentServiceImp.storageService;
      });
      osgi.injectService(ShopNotifierService,function(param1:Object):void {
        ShopNotifierModel.shopNotifierService = ShopNotifierService(param1);
      },function():ShopNotifierService {
        return ShopNotifierModel.shopNotifierService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        QuantityRestrictionModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return QuantityRestrictionModel.paymentDisplayService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RenameShopItemModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RenameShopItemModel.localeService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        PersonalDiscountModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return PersonalDiscountModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PersonalDiscountModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PersonalDiscountModel.localeService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        PersonalDiscountModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return PersonalDiscountModel.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PremiumAccountAlertModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PremiumAccountAlertModel.localeService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        PremiumAccountAlertModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return PremiumAccountAlertModel.notificationService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        PremiumAccountAlertModel.premiumService = PremiumService(param1);
      },function():PremiumService {
        return PremiumAccountAlertModel.premiumService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PremiumCompleteNotification.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PremiumCompleteNotification.localeService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        PremiumCompleteNotification.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return PremiumCompleteNotification.paymentDisplayService;
      });
      osgi.injectService(INotificationGarageCategoriesService,function(param1:Object):void {
        NewPresentsShowingModel.notificationGarageCategoriesService = INotificationGarageCategoriesService(param1);
      },function():INotificationGarageCategoriesService {
        return NewPresentsShowingModel.notificationGarageCategoriesService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        PresentSettingsModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return PresentSettingsModel.settingsService;
      });
      osgi.injectService(ThanksForDonationFormService,function(param1:Object):void {
        ShopPromoCodeModel.thanksForDonationFormService = ThanksForDonationFormService(param1);
      },function():ThanksForDonationFormService {
        return ShopPromoCodeModel.thanksForDonationFormService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChallengesProgressView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChallengesProgressView.localeService;
      });
      osgi.injectService(MissionsWindowsService,function(param1:Object):void {
        ChallengesTab.missionsWindowService = MissionsWindowsService(param1);
      },function():MissionsWindowsService {
        return ChallengesTab.missionsWindowService;
      });
      osgi.injectService(BattlePassPurchaseService,function(param1:Object):void {
        ChallengesView.battlePassPurchaseService = BattlePassPurchaseService(param1);
      },function():BattlePassPurchaseService {
        return ChallengesView.battlePassPurchaseService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        ChallengesView.challengeInfoService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return ChallengesView.challengeInfoService;
      });
      osgi.injectService(ChallengeShopItems,function(param1:Object):void {
        ChallengesView.challengeShopItems = ChallengeShopItems(param1);
      },function():ChallengeShopItems {
        return ChallengesView.challengeShopItems;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChallengesView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChallengesView.localeService;
      });
      osgi.injectService(MissionsWindowsService,function(param1:Object):void {
        ChallengesView.missionsWindowService = MissionsWindowsService(param1);
      },function():MissionsWindowsService {
        return ChallengesView.missionsWindowService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        ChallengesView.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return ChallengesView.partnerService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        ChallengesView.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return ChallengesView.paymentDisplayService;
      });
      osgi.injectService(StarsInfoService,function(param1:Object):void {
        ChallengesView.starsInfoService = StarsInfoService(param1);
      },function():StarsInfoService {
        return ChallengesView.starsInfoService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        ChallengesView.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return ChallengesView.userInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TierNumberView.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TierNumberView.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TierRenderer.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TierRenderer.localeService;
      });
      osgi.injectService(BattlePassPurchaseService,function(param1:Object):void {
        ChallengesRewardingModel.battlePassPurchaseService = BattlePassPurchaseService(param1);
      },function():BattlePassPurchaseService {
        return ChallengesRewardingModel.battlePassPurchaseService;
      });
      osgi.injectService(ChallengesViewService,function(param1:Object):void {
        ChallengesRewardingModel.challengeService = ChallengesViewService(param1);
      },function():ChallengesViewService {
        return ChallengesRewardingModel.challengeService;
      });
      osgi.injectService(MissionsWindowsService,function(param1:Object):void {
        ChallengesRewardingModel.missionsWindowService = MissionsWindowsService(param1);
      },function():MissionsWindowsService {
        return ChallengesRewardingModel.missionsWindowService;
      });
      osgi.injectService(StarsInfoService,function(param1:Object):void {
        ChallengesRewardingModel.starsInfoService = StarsInfoService(param1);
      },function():StarsInfoService {
        return ChallengesRewardingModel.starsInfoService;
      });
      osgi.injectService(ChallengesViewService,function(param1:Object):void {
        ChallengesRewardingUserModel.challengeViewService = ChallengesViewService(param1);
      },function():ChallengesViewService {
        return ChallengesRewardingUserModel.challengeViewService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChallengesRewardingUserModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChallengesRewardingUserModel.localeService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        ChallengesRewardingUserModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return ChallengesRewardingUserModel.notificationService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        StarsInfoModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return StarsInfoModel.panelView;
      });
      osgi.injectService(StarsInfoService,function(param1:Object):void {
        StarsInfoModel.starsInfoService = StarsInfoService(param1);
      },function():StarsInfoService {
        return StarsInfoModel.starsInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CommonQuestTab.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CommonQuestTab.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        QuestItemViewInfoPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return QuestItemViewInfoPanel.localeService;
      });
      osgi.injectService(IButtonBarService,function(param1:Object):void {
        QuestWindow.buttonBarService = IButtonBarService(param1);
      },function():IButtonBarService {
        return QuestWindow.buttonBarService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        QuestWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return QuestWindow.localeService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        QuestWindow.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return QuestWindow.userChangeGameScreenService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DailyQuestChangeButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DailyQuestChangeButton.localeService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        DailyQuestChangeButton.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return DailyQuestChangeButton.moneyService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        DailyQuestDisabledPrizeButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return DailyQuestDisabledPrizeButton.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        QuestGetPrizeButton.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return QuestGetPrizeButton.localeService;
      });
      osgi.injectService(QuestNotifierService,function(param1:Object):void {
        QuestTabButton.questNotifierService = QuestNotifierService(param1);
      },function():QuestNotifierService {
        return QuestTabButton.questNotifierService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        QuestTabButtonsList.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return QuestTabButtonsList.localeService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        QuestTabButtonsList.starsEventService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return QuestTabButtonsList.starsEventService;
      });
      osgi.injectService(QuestNotifierService,function(param1:Object):void {
        QuestNotifierModel.questNotifierService = QuestNotifierService(param1);
      },function():QuestNotifierService {
        return QuestNotifierModel.questNotifierService;
      });
      osgi.injectService(DailyQuestsService,function(param1:Object):void {
        DailyQuestShowingModel.dailyQuestService = DailyQuestsService(param1);
      },function():DailyQuestsService {
        return DailyQuestShowingModel.dailyQuestService;
      });
      osgi.injectService(MissionsWindowsService,function(param1:Object):void {
        DailyQuestShowingModel.missionsWindowsService = MissionsWindowsService(param1);
      },function():MissionsWindowsService {
        return DailyQuestShowingModel.missionsWindowsService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        DailyQuestShowingModel.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return DailyQuestShowingModel.moneyService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        DailyQuestItemView.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return DailyQuestItemView.moneyService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        DailyQuestTab.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return DailyQuestTab.moneyService;
      });
      osgi.injectService(QuestNotifierService,function(param1:Object):void {
        DailyQuestTab.questNotifierService = QuestNotifierService(param1);
      },function():QuestNotifierService {
        return DailyQuestTab.questNotifierService;
      });
      osgi.injectService(MissionsWindowsService,function(param1:Object):void {
        WeeklyQuestShowingModel.missionsWindowsService = MissionsWindowsService(param1);
      },function():MissionsWindowsService {
        return WeeklyQuestShowingModel.missionsWindowsService;
      });
      osgi.injectService(WeeklyQuestsService,function(param1:Object):void {
        WeeklyQuestShowingModel.weeklyQuestsService = WeeklyQuestsService(param1);
      },function():WeeklyQuestsService {
        return WeeklyQuestShowingModel.weeklyQuestsService;
      });
      osgi.injectService(QuestNotifierService,function(param1:Object):void {
        WeeklyQuestTab.questNotifierService = QuestNotifierService(param1);
      },function():QuestNotifierService {
        return WeeklyQuestTab.questNotifierService;
      });
      osgi.injectService(ReferralsService,function(param1:Object):void {
        ReferralsModel.referralService = ReferralsService(param1);
      },function():ReferralsService {
        return ReferralsModel.referralService;
      });
      osgi.injectService(NewReferralsNotifierService,function(param1:Object):void {
        NewReferralsNotifierModel.newReferralsNotifierService = NewReferralsNotifierService(param1);
      },function():NewReferralsNotifierService {
        return NewReferralsNotifierModel.newReferralsNotifierService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        RulesUpdateShowingModel.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return RulesUpdateShowingModel.dialogService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        SettingsModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return SettingsModel.alertService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        SettingsModel.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return SettingsModel.battleInviteService;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        SettingsModel.fullscreenService = FullscreenService(param1);
      },function():FullscreenService {
        return SettingsModel.fullscreenService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SettingsModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SettingsModel.localeService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        SettingsModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return SettingsModel.panelView;
      });
      osgi.injectService(PasswordService,function(param1:Object):void {
        SettingsModel.passwordService = PasswordService(param1);
      },function():PasswordService {
        return SettingsModel.passwordService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        SettingsModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return SettingsModel.settingsService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        SocialNetworkPanelModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return SocialNetworkPanelModel.alertService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SocialNetworkPanelModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SocialNetworkPanelModel.localeService;
      });
      osgi.injectService(ISocialNetworkPanelService,function(param1:Object):void {
        SocialNetworkPanelModel.socialNetworkService = ISocialNetworkPanelService(param1);
      },function():ISocialNetworkPanelService {
        return SocialNetworkPanelModel.socialNetworkService;
      });
      osgi.injectService(CountryService,function(param1:Object):void {
        UserCountryModel.countryService = CountryService(param1);
      },function():CountryService {
        return UserCountryModel.countryService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        UserCountryModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return UserCountryModel.lobbyLayoutService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        UserCountryModel.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return UserCountryModel.paymentDisplayService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        UserCountryModel.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return UserCountryModel.paymentService;
      });
      osgi.injectService(UserPaymentActionsService,function(param1:Object):void {
        UserCountryModel.userPaymentActionService = UserPaymentActionsService(param1);
      },function():UserPaymentActionsService {
        return UserCountryModel.userPaymentActionService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        UserEmailAndPasswordModel.alertService = IAlertService(param1);
      },function():IAlertService {
        return UserEmailAndPasswordModel.alertService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        UserEmailAndPasswordModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return UserEmailAndPasswordModel.panelView;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        UserEmailAndPasswordModel.settingService = ISettingsService(param1);
      },function():ISettingsService {
        return UserEmailAndPasswordModel.settingService;
      });
      osgi.injectService(ISocialNetworkPanelService,function(param1:Object):void {
        UserEmailAndPasswordModel.socialNetworkPanelService = ISocialNetworkPanelService(param1);
      },function():ISocialNetworkPanelService {
        return UserEmailAndPasswordModel.socialNetworkPanelService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        UserPropertiesModel.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return UserPropertiesModel.clanUserInfoService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        UserPropertiesModel.display = IDisplay(param1);
      },function():IDisplay {
        return UserPropertiesModel.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        UserPropertiesModel.helpService = IHelpService(param1);
      },function():IHelpService {
        return UserPropertiesModel.helpService;
      });
      osgi.injectService(IMoneyService,function(param1:Object):void {
        UserPropertiesModel.moneyService = IMoneyService(param1);
      },function():IMoneyService {
        return UserPropertiesModel.moneyService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        UserPropertiesModel.panelView = IPanelView(param1);
      },function():IPanelView {
        return UserPropertiesModel.panelView;
      });
      osgi.injectService(StarsInfoService,function(param1:Object):void {
        UserPropertiesModel.starsInfoService = StarsInfoService(param1);
      },function():StarsInfoService {
        return UserPropertiesModel.starsInfoService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        UserPropertiesModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return UserPropertiesModel.trackerService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        UserPropertiesModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return UserPropertiesModel.userPropertiesService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        UsersCounterModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return UsersCounterModel.storageService;
      });
      osgi.injectService(ClanPanelNotificationService,function(param1:Object):void {
        AchievementService.clanPanelNotification = ClanPanelNotificationService(param1);
      },function():ClanPanelNotificationService {
        return AchievementService.clanPanelNotification;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        AchievementService.display = IDisplay(param1);
      },function():IDisplay {
        return AchievementService.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        AchievementService.helpService = IHelpService(param1);
      },function():IHelpService {
        return AchievementService.helpService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        AchievementService.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return AchievementService.lobbyLayoutService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        AchievementService.partnersService = IPartnerService(param1);
      },function():IPartnerService {
        return AchievementService.partnersService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        BattleLinkActivatorService.alertService = IAlertService(param1);
      },function():IAlertService {
        return BattleLinkActivatorService.alertService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleLinkActivatorService.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleLinkActivatorService.battleInfoService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleLinkActivatorService.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleLinkActivatorService.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleLinkActivatorService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleLinkActivatorService.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BattleLinkActivatorService.storageService = IStorageService(param1);
      },function():IStorageService {
        return BattleLinkActivatorService.storageService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        BattleLinkActivatorService.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return BattleLinkActivatorService.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleLinkActivatorService.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleLinkActivatorService.userPropertyService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        FPSServiceImpl.dispay = IDisplay(param1);
      },function():IDisplay {
        return FPSServiceImpl.dispay;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        UserChangeGameScreenServiceImpl.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return UserChangeGameScreenServiceImpl.lobbyLayoutService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        MoneyService.alertService = IAlertService(param1);
      },function():IAlertService {
        return MoneyService.alertService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        MoneyService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return MoneyService.localeService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        MoneyService.panelView = IPanelView(param1);
      },function():IPanelView {
        return MoneyService.panelView;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        MoneyService.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return MoneyService.paymentService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        NotificationGarageCategoriesService.storageService = IStorageService(param1);
      },function():IStorageService {
        return NotificationGarageCategoriesService.storageService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        PanelView.alertService = IAlertService(param1);
      },function():IAlertService {
        return PanelView.alertService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        PanelView.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return PanelView.userChangeGameScreenService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        PaymentService.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return PaymentService.partnerService;
      });
      osgi.injectService(IAchievementService,function(param1:Object):void {
        PaymentDisplayServiceImpl.achievementService = IAchievementService(param1);
      },function():IAchievementService {
        return PaymentDisplayServiceImpl.achievementService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        PaymentDisplayServiceImpl.blurService = IBlurService(param1);
      },function():IBlurService {
        return PaymentDisplayServiceImpl.blurService;
      });
      osgi.injectService(CountryService,function(param1:Object):void {
        PaymentDisplayServiceImpl.countryService = CountryService(param1);
      },function():CountryService {
        return PaymentDisplayServiceImpl.countryService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        PaymentDisplayServiceImpl.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return PaymentDisplayServiceImpl.lobbyLayoutService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        PaymentDisplayServiceImpl.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return PaymentDisplayServiceImpl.modalLoaderService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        PaymentDisplayServiceImpl.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return PaymentDisplayServiceImpl.partnerService;
      });
      osgi.injectService(IPaymentService,function(param1:Object):void {
        PaymentDisplayServiceImpl.paymentService = IPaymentService(param1);
      },function():IPaymentService {
        return PaymentDisplayServiceImpl.paymentService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        PaymentDisplayServiceImpl.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return PaymentDisplayServiceImpl.userChangeGameScreenService;
      });
      osgi.injectService(UserPaymentActionsService,function(param1:Object):void {
        PaymentDisplayServiceImpl.userPaymentActionsService = UserPaymentActionsService(param1);
      },function():UserPaymentActionsService {
        return PaymentDisplayServiceImpl.userPaymentActionsService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        ReferralsButtonHelperServiceImpl.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return ReferralsButtonHelperServiceImpl.partnerService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        SettingsService.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return SettingsService.battleInviteService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        SettingsService.storageService = IStorageService(param1);
      },function():IStorageService {
        return SettingsService.storageService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        KeyCodesConverter.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return KeyCodesConverter.localeService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        SNFriendsServiceImpl.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return SNFriendsServiceImpl.partnerService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        UpgradingItemsServiceImpl.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return UpgradingItemsServiceImpl.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UpgradingItemsServiceImpl.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UpgradingItemsServiceImpl.localeService;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new UserAbonementsModel());
      modelRegister.add(new AchievementModel());
      modelRegister.add(new AndroidAppRatingModel());
      modelRegister.add(new AntiAddictionAlertModel());
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(IAntiAddictionAlert,IAntiAddictionAlertAdapt);
      modelRegisterAdapt.registerEvents(IAntiAddictionAlert,IAntiAddictionAlertEvents);
      modelRegister.add(new BonusImageShowingModel());
      modelRegisterAdapt.registerAdapt(BonusInfo,BonusInfoAdapt);
      modelRegisterAdapt.registerEvents(BonusInfo,BonusInfoEvents);
      modelRegister.add(new BonusInfoModel());
      modelRegisterAdapt.registerAdapt(BonusItem,BonusItemAdapt);
      modelRegisterAdapt.registerEvents(BonusItem,BonusItemEvents);
      modelRegister.add(new BonusItemModel());
      modelRegister.add(new BonusItemsShowingModel());
      modelRegister.add(new ChallengeShopItemsModel());
      modelRegister.add(new BattlePassPackageModel());
      modelRegister.add(new BattlePassPurchaseNotifierModel());
      modelRegister.add(new CoinInfoModel());
      modelRegister.add(new DonationProfileModel());
      modelRegister.add(new DonationAlertModel());
      modelRegisterAdapt.registerAdapt(ThanksForDonationFormService,ThanksForDonationFormServiceAdapt);
      modelRegisterAdapt.registerEvents(ThanksForDonationFormService,ThanksForDonationFormServiceEvents);
      modelRegister.add(new EmailReminderModel());
      modelRegisterAdapt.registerAdapt(EmailReminderService,EmailReminderServiceAdapt);
      modelRegisterAdapt.registerEvents(EmailReminderService,EmailReminderServiceEvents);
      modelRegister.add(new EntranceAlertModel());
      modelRegister.add(new BattleInviteModel());
      modelRegister.add(new FriendsLoaderModel());
      modelRegister.add(new AvailableItemsModel());
      modelRegister.add(new AvailableUpgradesModel());
      modelRegister.add(new RankUpSupplyBonusModel());
      modelRegisterAdapt.registerAdapt(ModuleResistances,ModuleResistancesAdapt);
      modelRegisterAdapt.registerEvents(ModuleResistances,ModuleResistancesEvents);
      modelRegister.add(new ResistancesListModel());
      modelRegister.add(new UpgradingItemsModel());
      modelRegister.add(new KitOfferModel());
      modelRegister.add(new MobileQuestModel());
      modelRegister.add(new MobileQuestProfileModel());
      modelRegister.add(new NewbiesAbonementShowInfoModel());
      modelRegister.add(new PanelModel());
      modelRegister.add(new PaymentButtonModel());
      modelRegister.add(new PaymentLoaderModel());
      modelRegister.add(new CrystalsPaymentModel());
      modelRegister.add(new PaymentModel());
      modelRegister.add(new AndroidBannerModel());
      modelRegister.add(new AndroidPurchaseOfUpgradesModel());
      modelRegister.add(new AndroidPurchaseOfUpgradesUserModel());
      modelRegister.add(new AndroidSpecialOfferModel());
      modelRegister.add(new MediumTimeOfferModel());
      modelRegister.add(new ShopItemLoaderForAndroidModel());
      modelRegisterAdapt.registerAdapt(PayFullDescription,PayFullDescriptionAdapt);
      modelRegisterAdapt.registerEvents(PayFullDescription,PayFullDescriptionEvents);
      modelRegisterAdapt.registerAdapt(PayModeView,PayModeViewAdapt);
      modelRegisterAdapt.registerEvents(PayModeView,PayModeViewEvents);
      modelRegisterAdapt.registerAdapt(CrystalsOnlyPaymentMode,CrystalsOnlyPaymentModeAdapt);
      modelRegisterAdapt.registerEvents(CrystalsOnlyPaymentMode,CrystalsOnlyPaymentModeEvents);
      modelRegisterAdapt.registerAdapt(PayMode,PayModeAdapt);
      modelRegisterAdapt.registerEvents(PayMode,PayModeEvents);
      modelRegisterAdapt.registerAdapt(PayModeDescription,PayModeDescriptionAdapt);
      modelRegisterAdapt.registerEvents(PayModeDescription,PayModeDescriptionEvents);
      modelRegisterAdapt.registerAdapt(PayModeManualDescription,PayModeManualDescriptionAdapt);
      modelRegisterAdapt.registerEvents(PayModeManualDescription,PayModeManualDescriptionEvents);
      modelRegisterAdapt.registerAdapt(PayUrl,PayUrlAdapt);
      modelRegisterAdapt.registerEvents(PayUrl,PayUrlEvents);
      modelRegister.add(new PaymentModeModel());
      modelRegister.add(new AlipayPaymentModel());
      modelRegisterAdapt.registerAdapt(AsyncUrlPayMode,AsyncUrlPayModeAdapt);
      modelRegisterAdapt.registerEvents(AsyncUrlPayMode,AsyncUrlPayModeEvents);
      modelRegister.add(new AsyncUrlPayModel());
      modelRegisterAdapt.registerAdapt(BraintreePayment,BraintreePaymentAdapt);
      modelRegisterAdapt.registerEvents(BraintreePayment,BraintreePaymentEvents);
      modelRegister.add(new BraintreePaymentModel());
      modelRegisterAdapt.registerAdapt(PayModeBottomDescription,PayModeBottomDescriptionAdapt);
      modelRegisterAdapt.registerEvents(PayModeBottomDescription,PayModeBottomDescriptionEvents);
      modelRegisterAdapt.registerAdapt(PayModeBottomDescriptionInternal,PayModeBottomDescriptionInternalAdapt);
      modelRegisterAdapt.registerEvents(PayModeBottomDescriptionInternal,PayModeBottomDescriptionInternalEvents);
      modelRegister.add(new PayModeBottomDescriptionModel());
      modelRegisterAdapt.registerAdapt(ErrorDescription,ErrorDescriptionAdapt);
      modelRegisterAdapt.registerEvents(ErrorDescription,ErrorDescriptionEvents);
      modelRegister.add(new ErrorsDescriptionModel());
      modelRegisterAdapt.registerAdapt(Gate2ShopPayment,Gate2ShopPaymentAdapt);
      modelRegisterAdapt.registerEvents(Gate2ShopPayment,Gate2ShopPaymentEvents);
      modelRegister.add(new Gate2ShopPaymentModel());
      modelRegister.add(new LeogamingPaymentMobileModel());
      modelRegisterAdapt.registerAdapt(LeogamingPaymentMode,LeogamingPaymentModeAdapt);
      modelRegisterAdapt.registerEvents(LeogamingPaymentMode,LeogamingPaymentModeEvents);
      modelRegisterAdapt.registerAdapt(OnlyUrlPayMode,OnlyUrlPayModeAdapt);
      modelRegisterAdapt.registerEvents(OnlyUrlPayMode,OnlyUrlPayModeEvents);
      modelRegister.add(new OnlyUrlPaymentModel());
      modelRegisterAdapt.registerAdapt(PayGardenPayment,PayGardenPaymentAdapt);
      modelRegisterAdapt.registerEvents(PayGardenPayment,PayGardenPaymentEvents);
      modelRegister.add(new PayGardenPaymentModel());
      modelRegisterAdapt.registerAdapt(PayPalPayment,PayPalPaymentAdapt);
      modelRegisterAdapt.registerEvents(PayPalPayment,PayPalPaymentEvents);
      modelRegister.add(new PayPalPaymentModel());
      modelRegister.add(new PlatBoxPaymentModel());
      modelRegisterAdapt.registerAdapt(PriceRange,PriceRangeAdapt);
      modelRegisterAdapt.registerEvents(PriceRange,PriceRangeEvents);
      modelRegister.add(new PriceRangeModel());
      modelRegisterAdapt.registerAdapt(QiwiPayment,QiwiPaymentAdapt);
      modelRegisterAdapt.registerEvents(QiwiPayment,QiwiPaymentEvents);
      modelRegister.add(new QiwiPaymentModel());
      modelRegisterAdapt.registerAdapt(SMSPayMode,SMSPayModeAdapt);
      modelRegisterAdapt.registerEvents(SMSPayMode,SMSPayModeEvents);
      modelRegister.add(new SMSPayModeModel());
      modelRegisterAdapt.registerAdapt(TerminalPayMode,TerminalPayModeAdapt);
      modelRegisterAdapt.registerEvents(TerminalPayMode,TerminalPayModeEvents);
      modelRegister.add(new TerminalPaymentModel());
      modelRegister.add(new GoToUrlPaymentModel());
      modelRegisterAdapt.registerAdapt(ShopItemDetailsView,ShopItemDetailsViewAdapt);
      modelRegisterAdapt.registerEvents(ShopItemDetailsView,ShopItemDetailsViewEvents);
      modelRegisterAdapt.registerAdapt(ShopItemView,ShopItemViewAdapt);
      modelRegisterAdapt.registerEvents(ShopItemView,ShopItemViewEvents);
      modelRegisterAdapt.registerAdapt(CashPackage,CashPackageAdapt);
      modelRegisterAdapt.registerEvents(CashPackage,CashPackageEvents);
      modelRegisterAdapt.registerAdapt(ShopCategory,ShopCategoryAdapt);
      modelRegisterAdapt.registerEvents(ShopCategory,ShopCategoryEvents);
      modelRegister.add(new ShopCategoryModel());
      modelRegister.add(new CoinPackageModel());
      modelRegisterAdapt.registerAdapt(CrystalPackage,CrystalPackageAdapt);
      modelRegisterAdapt.registerEvents(CrystalPackage,CrystalPackageEvents);
      modelRegister.add(new CrystalPackageModel());
      modelRegisterAdapt.registerAdapt(ShopItemAdditionalDescription,ShopItemAdditionalDescriptionAdapt);
      modelRegisterAdapt.registerEvents(ShopItemAdditionalDescription,ShopItemAdditionalDescriptionEvents);
      modelRegister.add(new ShopItemAdditionalDescriptionModel());
      modelRegisterAdapt.registerAdapt(ShopDiscount,ShopDiscountAdapt);
      modelRegisterAdapt.registerEvents(ShopDiscount,ShopDiscountEvents);
      modelRegister.add(new ShopDiscountModel());
      modelRegister.add(new EmailRequiredModel());
      modelRegisterAdapt.registerAdapt(ShopItemEmailRequired,ShopItemEmailRequiredAdapt);
      modelRegisterAdapt.registerEvents(ShopItemEmailRequired,ShopItemEmailRequiredEvents);
      modelRegisterAdapt.registerAdapt(ShopItemFeaturing,ShopItemFeaturingAdapt);
      modelRegisterAdapt.registerEvents(ShopItemFeaturing,ShopItemFeaturingEvents);
      modelRegister.add(new ShopItemFeaturingModel());
      modelRegisterAdapt.registerAdapt(GoldBoxPackage,GoldBoxPackageAdapt);
      modelRegisterAdapt.registerEvents(GoldBoxPackage,GoldBoxPackageEvents);
      modelRegister.add(new GoldBoxPackageModel());
      modelRegisterAdapt.registerAdapt(Indemnity,IndemnityAdapt);
      modelRegisterAdapt.registerEvents(Indemnity,IndemnityEvents);
      modelRegister.add(new IndemnityModel());
      modelRegisterAdapt.registerAdapt(ShopItem,ShopItemAdapt);
      modelRegisterAdapt.registerEvents(ShopItem,ShopItemEvents);
      modelRegister.add(new ShopItemModel());
      modelRegisterAdapt.registerAdapt(ShopItemCategory,ShopItemCategoryAdapt);
      modelRegisterAdapt.registerEvents(ShopItemCategory,ShopItemCategoryEvents);
      modelRegister.add(new ShopItemCategoryModel());
      modelRegisterAdapt.registerAdapt(KitPackage,KitPackageAdapt);
      modelRegisterAdapt.registerEvents(KitPackage,KitPackageEvents);
      modelRegister.add(new KitPackageModel());
      modelRegister.add(new KitPackageViewModel());
      modelRegister.add(new KitViewButtonWithPriceModel());
      modelRegisterAdapt.registerAdapt(KitViewResource,KitViewResourceAdapt);
      modelRegisterAdapt.registerEvents(KitViewResource,KitViewResourceEvents);
      modelRegister.add(new KitViewResourceModel());
      modelRegister.add(new KitViewResourceLocalizedModel());
      modelRegister.add(new LicenseClanShopItemModel());
      modelRegisterAdapt.registerAdapt(LootBoxPackage,LootBoxPackageAdapt);
      modelRegisterAdapt.registerEvents(LootBoxPackage,LootBoxPackageEvents);
      modelRegister.add(new LootBoxPackageModel());
      modelRegister.add(new LootboxAndPaintModel());
      modelRegister.add(new ShopNotifierModel());
      modelRegister.add(new EventOneTimePurchaseModel());
      modelRegisterAdapt.registerAdapt(ShopItemOneTimePurchase,ShopItemOneTimePurchaseAdapt);
      modelRegisterAdapt.registerEvents(ShopItemOneTimePurchase,ShopItemOneTimePurchaseEvents);
      modelRegister.add(new ShopItemOneTimePurchaseModel());
      modelRegisterAdapt.registerAdapt(PaintPackage,PaintPackageAdapt);
      modelRegisterAdapt.registerEvents(PaintPackage,PaintPackageEvents);
      modelRegister.add(new PaintPackageModel());
      modelRegisterAdapt.registerAdapt(PremiumPackage,PremiumPackageAdapt);
      modelRegisterAdapt.registerEvents(PremiumPackage,PremiumPackageEvents);
      modelRegister.add(new PremiumPackageModel());
      modelRegisterAdapt.registerAdapt(QuantityRestriction,QuantityRestrictionAdapt);
      modelRegisterAdapt.registerEvents(QuantityRestriction,QuantityRestrictionEvents);
      modelRegister.add(new QuantityRestrictionModel());
      modelRegister.add(new RenameShopItemModel());
      modelRegister.add(new KitBundleViewModel());
      modelRegister.add(new ActiveShopAbonementsModel());
      modelRegisterAdapt.registerAdapt(ShopAbonements,ShopAbonementsAdapt);
      modelRegisterAdapt.registerEvents(ShopAbonements,ShopAbonementsEvents);
      modelRegister.add(new RestrictionByPayModeModel());
      modelRegisterAdapt.registerAdapt(SinglePayMode,SinglePayModeAdapt);
      modelRegisterAdapt.registerEvents(SinglePayMode,SinglePayModeEvents);
      modelRegisterAdapt.registerAdapt(SpecialKitPackage,SpecialKitPackageAdapt);
      modelRegisterAdapt.registerEvents(SpecialKitPackage,SpecialKitPackageEvents);
      modelRegister.add(new SpecialKitPackageModel());
      modelRegister.add(new NewbieKitViewModel());
      modelRegisterAdapt.registerAdapt(PayPalKitView,PayPalKitViewAdapt);
      modelRegisterAdapt.registerEvents(PayPalKitView,PayPalKitViewEvents);
      modelRegister.add(new PayPalKitViewModel());
      modelRegister.add(new SingleItemKitViewModel());
      modelRegister.add(new PersonalDiscountModel());
      modelRegister.add(new PremiumAccountAlertModel());
      modelRegister.add(new NewPresentsShowingModel());
      modelRegister.add(new PresentSettingsModel());
      modelRegister.add(new AndroidRenameModel());
      modelRegisterAdapt.registerAdapt(ShopPromoCode,ShopPromoCodeAdapt);
      modelRegisterAdapt.registerEvents(ShopPromoCode,ShopPromoCodeEvents);
      modelRegister.add(new ShopPromoCodeModel());
      modelRegister.add(new FirebasePushNotificationPanelUserProfileModel());
      modelRegister.add(new ChallengesRewardingModel());
      modelRegister.add(new ChallengesRewardingUserModel());
      modelRegister.add(new StarsInfoModel());
      modelRegister.add(new QuestNotifierModel());
      modelRegister.add(new DailyQuestShowingModel());
      modelRegister.add(new WeeklyQuestShowingModel());
      modelRegister.add(new RankUpBonusAlertModel());
      modelRegister.add(new ReferralsModel());
      modelRegister.add(new NewReferralsNotifierModel());
      modelRegister.add(new RulesUpdateShowingModel());
      modelRegister.add(new SettingsModel());
      modelRegister.add(new SocialNetworkPanelModel());
      modelRegister.add(new SNGroupReminderModel());
      modelRegister.add(new TutorialHintsModel());
      modelRegister.add(new UserCountryModel());
      modelRegisterAdapt.registerAdapt(IUserEmailAndPassword,IUserEmailAndPasswordAdapt);
      modelRegisterAdapt.registerEvents(IUserEmailAndPassword,IUserEmailAndPasswordEvents);
      modelRegisterAdapt.registerAdapt(PasswordService,PasswordServiceAdapt);
      modelRegisterAdapt.registerEvents(PasswordService,PasswordServiceEvents);
      modelRegister.add(new UserEmailAndPasswordModel());
      modelRegisterAdapt.registerAdapt(IUserProperties,IUserPropertiesAdapt);
      modelRegisterAdapt.registerEvents(IUserProperties,IUserPropertiesEvents);
      modelRegister.add(new UserPropertiesModel());
      modelRegister.add(new UsersCounterModel());
      modelRegister.add(new VideoAdsBattleResultModel());
      modelRegister.add(new VideoAdsModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
