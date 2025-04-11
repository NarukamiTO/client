package projects.tanks.clients.fp10.tanksformsflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import controls.Rank;
  import controls.dropdownlist.AccountsList;
  import controls.dropdownlist.DropDownList;
  import controls.panel.UpdateRankNotice;
  import controls.statassets.StatHeader;
  import controls.timer.CountDownTimer;
  import forms.ChangeTeamAlert;
  import forms.ServerRedirectAlert;
  import forms.ServerStopAlert;
  import forms.TankWindowWithHeader;
  import forms.contextmenu.ContextMenu;
  import forms.payment.PaymentListHeader;
  import forms.ranks.RankIcon;
  import forms.registration.bubbles.EmailInvalidBubble;
  import forms.registration.bubbles.NameIsIncorrectBubble;
  import forms.registration.bubbles.NameIsNotUniqueBubble;
  import forms.registration.bubbles.PasswordIsTooEasyBubble;
  import forms.registration.bubbles.PasswordsDoNotMatchBubble;
  import forms.stat.StatListRenderer;
  import forms.userlabel.UserLabel;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanFunctionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.group.IGroupInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.alertservice.AlertService;
  import services.contextmenu.ContextMenuService;
  import services.contextmenu.IContextMenuService;
  import utils.GUIDebugger;
  import utils.TimeFormatter;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(ILocaleService,function(param1:Object):void {
        Rank.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return Rank.localeService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        AccountsList.storageService = IStorageService(param1);
      },function():IStorageService {
        return AccountsList.storageService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        DropDownList.display = IDisplay(param1);
      },function():IDisplay {
        return DropDownList.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UpdateRankNotice.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UpdateRankNotice.localeService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        UpdateRankNotice.premiumService = PremiumService(param1);
      },function():PremiumService {
        return UpdateRankNotice.premiumService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        UpdateRankNotice.rankService = RankService(param1);
      },function():RankService {
        return UpdateRankNotice.rankService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        StatHeader.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return StatHeader.localeService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        CountDownTimer.logService = LogService(param1);
      },function():LogService {
        return CountDownTimer.logService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ChangeTeamAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ChangeTeamAlert.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ServerRedirectAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ServerRedirectAlert.localeService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ServerStopAlert.display = IDisplay(param1);
      },function():IDisplay {
        return ServerStopAlert.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ServerStopAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ServerStopAlert.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TankWindowWithHeader.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TankWindowWithHeader.localeService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ContextMenu.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ContextMenu.battleInfoService;
      });
      osgi.injectService(IBattleInviteService,function(param1:Object):void {
        ContextMenu.battleInviteService = IBattleInviteService(param1);
      },function():IBattleInviteService {
        return ContextMenu.battleInviteService;
      });
      osgi.injectService(IBlockUserService,function(param1:Object):void {
        ContextMenu.blockUserService = IBlockUserService(param1);
      },function():IBlockUserService {
        return ContextMenu.blockUserService;
      });
      osgi.injectService(ClanFunctionsService,function(param1:Object):void {
        ContextMenu.clanFunctionsService = ClanFunctionsService(param1);
      },function():ClanFunctionsService {
        return ContextMenu.clanFunctionsService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        ContextMenu.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return ContextMenu.clanUserInfoService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        ContextMenu.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return ContextMenu.contextMenuService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ContextMenu.display = IDisplay(param1);
      },function():IDisplay {
        return ContextMenu.display;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ContextMenu.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ContextMenu.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ContextMenu.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ContextMenu.localeService;
      });
      osgi.injectService(IOnlineNotifierService,function(param1:Object):void {
        ContextMenu.onlineNotifierService = IOnlineNotifierService(param1);
      },function():IOnlineNotifierService {
        return ContextMenu.onlineNotifierService;
      });
      osgi.injectService(IPartnerService,function(param1:Object):void {
        ContextMenu.partnerService = IPartnerService(param1);
      },function():IPartnerService {
        return ContextMenu.partnerService;
      });
      osgi.injectService(UserChangeGameScreenService,function(param1:Object):void {
        ContextMenu.userChangeGameScreenService = UserChangeGameScreenService(param1);
      },function():UserChangeGameScreenService {
        return ContextMenu.userChangeGameScreenService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        ContextMenu.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return ContextMenu.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ContextMenu.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ContextMenu.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PaymentListHeader.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PaymentListHeader.localeService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        RankIcon.rankService = RankService(param1);
      },function():RankService {
        return RankIcon.rankService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EmailInvalidBubble.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EmailInvalidBubble.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        NameIsIncorrectBubble.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return NameIsIncorrectBubble.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        NameIsNotUniqueBubble.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return NameIsNotUniqueBubble.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PasswordIsTooEasyBubble.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PasswordIsTooEasyBubble.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PasswordsDoNotMatchBubble.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PasswordsDoNotMatchBubble.localeService;
      });
      osgi.injectService(RankService,function(param1:Object):void {
        StatListRenderer.rankService = RankService(param1);
      },function():RankService {
        return StatListRenderer.rankService;
      });
      osgi.injectService(BattleUserPremiumService,function(param1:Object):void {
        UserLabel.battlePremiumService = BattleUserPremiumService(param1);
      },function():BattleUserPremiumService {
        return UserLabel.battlePremiumService;
      });
      osgi.injectService(ClanUserInfoService,function(param1:Object):void {
        UserLabel.clanUserInfoService = ClanUserInfoService(param1);
      },function():ClanUserInfoService {
        return UserLabel.clanUserInfoService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        UserLabel.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return UserLabel.contextMenuService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        UserLabel.display = IDisplay(param1);
      },function():IDisplay {
        return UserLabel.display;
      });
      osgi.injectService(IFriendInfoService,function(param1:Object):void {
        UserLabel.friendInfoService = IFriendInfoService(param1);
      },function():IFriendInfoService {
        return UserLabel.friendInfoService;
      });
      osgi.injectService(IGroupInfoService,function(param1:Object):void {
        UserLabel.groupInfoService = IGroupInfoService(param1);
      },function():IGroupInfoService {
        return UserLabel.groupInfoService;
      });
      osgi.injectService(PremiumService,function(param1:Object):void {
        UserLabel.premiumService = PremiumService(param1);
      },function():PremiumService {
        return UserLabel.premiumService;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        UserLabel.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return UserLabel.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        UserLabel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return UserLabel.userPropertiesService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        AlertService.blurService = IBlurService(param1);
      },function():IBlurService {
        return AlertService.blurService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        AlertService.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return AlertService.dialogWindowsDispatcherService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        AlertService.display = IDisplay(param1);
      },function():IDisplay {
        return AlertService.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AlertService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AlertService.localeService;
      });
      osgi.injectService(IAlertService,function(param1:Object):void {
        ContextMenuService.alertService = IAlertService(param1);
      },function():IAlertService {
        return ContextMenuService.alertService;
      });
      osgi.injectService(IFriendActionService,function(param1:Object):void {
        ContextMenuService.friendsActionService = IFriendActionService(param1);
      },function():IFriendActionService {
        return ContextMenuService.friendsActionService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ContextMenuService.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ContextMenuService.localeService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        GUIDebugger.display = IDisplay(param1);
      },function():IDisplay {
        return GUIDebugger.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TimeFormatter.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TimeFormatter.localeService;
      });
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
