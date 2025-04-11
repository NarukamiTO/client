package projects.tanks.clients.fp10.models.tankschatmodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.chat.CautionExternalLinkWindow;
  import alternativa.tanks.gui.communication.CommunicationPanel;
  import alternativa.tanks.gui.communication.tabs.chat.ChatTab;
  import alternativa.tanks.gui.communication.tabs.chat.IChatTabView;
  import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatTab;
  import alternativa.tanks.gui.communication.tabs.clanchat.IClanChatView;
  import alternativa.tanks.gui.communication.tabs.news.NewsTab;
  import alternativa.tanks.gui.news.NewsAlertWindow;
  import alternativa.tanks.gui.news.NewsItem;
  import alternativa.tanks.model.CommunicationPanelModel;
  import alternativa.tanks.model.chat.ChatModel;
  import alternativa.tanks.model.chat.ChatSettingsTracker;
  import alternativa.tanks.model.clanchat.ClanChatModel;
  import alternativa.tanks.model.news.NewsShowingModel;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.services.NewsService;
  import alternativa.tanks.services.NewsServiceImpl;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.utils.Antiflood;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.serverrestarttime.OnceADayActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.contextmenu.IContextMenuService;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CautionExternalLinkWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CautionExternalLinkWindow.localeService;
      });
      osgi.injectService(IChatTabView,function(param1:Object):void {
        CommunicationPanel.chatTabView = IChatTabView(param1);
      },function():IChatTabView {
        return CommunicationPanel.chatTabView;
      });
      osgi.injectService(IClanChatView,function(param1:Object):void {
        CommunicationPanel.clanChatView = IClanChatView(param1);
      },function():IClanChatView {
        return CommunicationPanel.clanChatView;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        CommunicationPanel.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return CommunicationPanel.clanUserInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CommunicationPanel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CommunicationPanel.localeService;
      });
      osgi.injectService(NewsService,function(param1:Object):void {
        CommunicationPanel.newsService = NewsService(param1);
      },function():NewsService {
        return CommunicationPanel.newsService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        CommunicationPanel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return CommunicationPanel.settingsService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        CommunicationPanel.storageService = IStorageService(param1);
      },function():IStorageService {
        return CommunicationPanel.storageService;
      });
      osgi.injectService(IBlockUserService,function(param1:Object):void {
        ChatTab.blockUserService = IBlockUserService(param1);
      },function():IBlockUserService {
        return ChatTab.blockUserService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        ChatTab.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return ChatTab.contextMenuService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChatTab.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChatTab.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        ChatTab.storageService = IStorageService(param1);
      },function():IStorageService {
        return ChatTab.storageService;
      });
      osgi.injectService(IBlockUserService,function(param1:Object):void {
        ClanChatTab.blockUserService = IBlockUserService(param1);
      },function():IBlockUserService {
        return ClanChatTab.blockUserService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        ClanChatTab.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return ClanChatTab.contextMenuService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ClanChatTab.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ClanChatTab.localeService;
      });
      osgi.injectService(NewsService,function(param1:Object):void {
        NewsTab.newsService = NewsService(param1);
      },function():NewsService {
        return NewsTab.newsService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        NewsAlertWindow.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return NewsAlertWindow.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        NewsItem.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return NewsItem.localeService;
      });
      osgi.injectService(NewsService,function(param1:Object):void {
        NewsItem.newsService = NewsService(param1);
      },function():NewsService {
        return NewsItem.newsService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        NewsItem.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return NewsItem.paymentDisplayService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        NewsItem.rankService = RankService(param1);
      },function():RankService {
        return NewsItem.rankService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        NewsItem.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return NewsItem.userPropertiesService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        CommunicationPanelModel.display = IDisplay(param1);
      },function():IDisplay {
        return CommunicationPanelModel.display;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        CommunicationPanelModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return CommunicationPanelModel.userPropertiesService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        ChatModel.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return ChatModel.battleLinkActivatorService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        ChatModel.clientLog = IClientLog(param1);
      },function():IClientLog {
        return ChatModel.clientLog;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ChatModel.display = IDisplay(param1);
      },function():IDisplay {
        return ChatModel.display;
      });
      osgi.injectService(IChatTabView,function(param1:Object):void {
        ChatModel.lobbyChatView = IChatTabView(param1);
      },function():IChatTabView {
        return ChatModel.lobbyChatView;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChatModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChatModel.localeService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        ChatModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return ChatModel.trackerService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ChatModel.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ChatModel.userPropertyService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        ChatSettingsTracker.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return ChatSettingsTracker.settingsService;
      });
      osgi.injectService(IBattleLinkActivatorService,function(param1:Object):void {
        ClanChatModel.battleLinkActivatorService = IBattleLinkActivatorService(param1);
      },function():IBattleLinkActivatorService {
        return ClanChatModel.battleLinkActivatorService;
      });
      osgi.injectService(IClanChatView,function(param1:Object):void {
        ClanChatModel.clanChatView = IClanChatView(param1);
      },function():IClanChatView {
        return ClanChatModel.clanChatView;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        ClanChatModel.clientLog = IClientLog(param1);
      },function():IClientLog {
        return ClanChatModel.clientLog;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ClanChatModel.display = IDisplay(param1);
      },function():IDisplay {
        return ClanChatModel.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ClanChatModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ClanChatModel.localeService;
      });
      osgi.injectService(ITrackerService,function(param1:Object):void {
        ClanChatModel.trackerService = ITrackerService(param1);
      },function():ITrackerService {
        return ClanChatModel.trackerService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ClanChatModel.userPropertyService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ClanChatModel.userPropertyService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        NewsShowingModel.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return NewsShowingModel.dialogService;
      });
      osgi.injectService(NewsService,function(param1:Object):void {
        NewsShowingModel.newsService = NewsService(param1);
      },function():NewsService {
        return NewsShowingModel.newsService;
      });
      osgi.injectService(OnceADayActionService,function(param1:Object):void {
        NewsShowingModel.onceADayActionService = OnceADayActionService(param1);
      },function():OnceADayActionService {
        return NewsShowingModel.onceADayActionService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        NewsShowingModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return NewsShowingModel.userPropertiesService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        NewsServiceImpl.storageService = IStorageService(param1);
      },function():IStorageService {
        return NewsServiceImpl.storageService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        Antiflood.clientLog = IClientLog(param1);
      },function():IClientLog {
        return Antiflood.clientLog;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new CommunicationPanelModel());
      modelRegister.add(new ChatModel());
      modelRegister.add(new ClanChatModel());
      modelRegister.add(new NewsShowingModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
