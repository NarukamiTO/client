package projects.tanks.clients.fp10.models.battlefieldmodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.dump.IDumpService;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.battle.PerformanceControllerWithThrottling;
  import alternativa.tanks.battle.SpeedHackChecker;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.notificationpausefinish.EndsPauseAlert;
  import alternativa.tanks.battle.notificationpausefinish.NotificationEndsPauseSupport;
  import alternativa.tanks.battle.objects.tank.controllers.LocalChassisController;
  import alternativa.tanks.battle.objects.tank.controllers.LocalCheatController;
  import alternativa.tanks.battle.objects.tank.controllers.LocalShaftController;
  import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
  import alternativa.tanks.battle.objects.tank.controllers.ShaftReticleDisplayController;
  import alternativa.tanks.battle.objects.tank.skintexturesregistry.TankSkinTextureRegistry;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.materialfactory.DebugBitmapLayer;
  import alternativa.tanks.battle.objects.tank.tankskin.materialfactory.DefaultTankSkinMaterialsFactory;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkinAdapt;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkinEvents;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
  import alternativa.tanks.battle.scene3d.BattleScene3DDebugCommands;
  import alternativa.tanks.battle.scene3d.FadingDecalsRenderer;
  import alternativa.tanks.bg.IBackgroundService;
  import alternativa.tanks.bonuses.BattleBonus;
  import alternativa.tanks.bonuses.BonusMesh;
  import alternativa.tanks.bonuses.BonusObject3DBase;
  import alternativa.tanks.bonuses.BonusPickupAnimation;
  import alternativa.tanks.bonuses.GroundSpawnRenderer;
  import alternativa.tanks.bonuses.ParachuteDetachAnimation;
  import alternativa.tanks.bonuses.RemovalAnimation;
  import alternativa.tanks.bonuses.SpawnAnimation;
  import alternativa.tanks.bonuses.SpawnFlashRenderer;
  import alternativa.tanks.camera.CameraBookmark;
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.camera.controllers.spectator.PlayerCamera;
  import alternativa.tanks.camera.controllers.spectator.SpectatorBonusRegionController;
  import alternativa.tanks.camera.controllers.spectator.SpectatorCameraController;
  import alternativa.tanks.camera.controllers.spectator.SpectatorSupport;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureMaterialRegistryBase;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.models.battle.assault.AssaultHudIndicators;
  import alternativa.tanks.models.battle.assault.AssaultMessages;
  import alternativa.tanks.models.battle.assault.AssaultModel;
  import alternativa.tanks.models.battle.assault.PointBaseIndicatorPlane;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleModelAdapt;
  import alternativa.tanks.models.battle.battlefield.BattleModelEvents;
  import alternativa.tanks.models.battle.battlefield.BattleSfx;
  import alternativa.tanks.models.battle.battlefield.BattleSfxAdapt;
  import alternativa.tanks.models.battle.battlefield.BattleSfxEvents;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.battlefield.BattlefieldEvents;
  import alternativa.tanks.models.battle.battlefield.BattlefieldEventsAdapt;
  import alternativa.tanks.models.battle.battlefield.BattlefieldEventsEvents;
  import alternativa.tanks.models.battle.battlefield.BattlefieldModel;
  import alternativa.tanks.models.battle.battlefield.FollowCameraControllerLocker;
  import alternativa.tanks.models.battle.battlefield.FreeCameraSupport;
  import alternativa.tanks.models.battle.battlefield.SpectatorFogToggleSupport;
  import alternativa.tanks.models.battle.battlefield.SpectatorUserTitleRenderer;
  import alternativa.tanks.models.battle.battlefield.StageFrameRateController;
  import alternativa.tanks.models.battle.battlefield.billboard.BillboardsDebugCommands;
  import alternativa.tanks.models.battle.battlefield.billboard.BillboardsModel;
  import alternativa.tanks.models.battle.battlefield.billboard.billboardimage.BillboardImageModel;
  import alternativa.tanks.models.battle.battlefield.keyboard.AdditionUserTitleSwitcher;
  import alternativa.tanks.models.battle.battlefield.map.Billboards;
  import alternativa.tanks.models.battle.battlefield.map.MapBuilder;
  import alternativa.tanks.models.battle.battlefield.mine.BattleMinesModel;
  import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModel;
  import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModelAdapt;
  import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModelEvents;
  import alternativa.tanks.models.battle.battlefield.mine.ProximityMine;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.battle.commonflag.Flag;
  import alternativa.tanks.models.battle.commonflag.FlagNotification;
  import alternativa.tanks.models.battle.commonflag.FlagNotificationAdapt;
  import alternativa.tanks.models.battle.commonflag.FlagNotificationEvents;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModelAdapt;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModelEvents;
  import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizer;
  import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizerAdapt;
  import alternativa.tanks.models.battle.commonflag.IFlagModeInitilizerEvents;
  import alternativa.tanks.models.battle.commonflag.MarkersUtils;
  import alternativa.tanks.models.battle.commonflag.PointBasedBattleModel;
  import alternativa.tanks.models.battle.ctf.CTFHudIndicators;
  import alternativa.tanks.models.battle.ctf.CTFMessages;
  import alternativa.tanks.models.battle.ctf.CTFModel;
  import alternativa.tanks.models.battle.ctf.FlagMessage;
  import alternativa.tanks.models.battle.ctf.FlagPickupTimeoutTask;
  import alternativa.tanks.models.battle.debug.BattleDebugModel;
  import alternativa.tanks.models.battle.dm.BattleDMModel;
  import alternativa.tanks.models.battle.facilities.BattleFacilities;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesAdapt;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesChecker;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesCheckerAdapt;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesCheckerEvents;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesEvents;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesModel;
  import alternativa.tanks.models.battle.facilities.BattleUnloadListener;
  import alternativa.tanks.models.battle.facilities.BattleUnloadListenerAdapt;
  import alternativa.tanks.models.battle.facilities.BattleUnloadListenerEvents;
  import alternativa.tanks.models.battle.facilities.CommonFacilityModel;
  import alternativa.tanks.models.battle.facilities.FacilityDispellEffect;
  import alternativa.tanks.models.battle.facilities.FacilityDispellEffectAdapt;
  import alternativa.tanks.models.battle.facilities.FacilityDispellEffectEvents;
  import alternativa.tanks.models.battle.facilities.FacilitySphericalZone;
  import alternativa.tanks.models.battle.facilities.FacilitySphericalZoneAdapt;
  import alternativa.tanks.models.battle.facilities.FacilitySphericalZoneEvents;
  import alternativa.tanks.models.battle.facilities.FacilitySphericalZoneModel;
  import alternativa.tanks.models.battle.facilities.ICommonFacility;
  import alternativa.tanks.models.battle.facilities.ICommonFacilityAdapt;
  import alternativa.tanks.models.battle.facilities.ICommonFacilityEvents;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.BattlefieldGUIAdapt;
  import alternativa.tanks.models.battle.gui.BattlefieldGUIEvents;
  import alternativa.tanks.models.battle.gui.chat.BattleChat;
  import alternativa.tanks.models.battle.gui.chat.BattleChatLine;
  import alternativa.tanks.models.battle.gui.chat.BattleChatModel;
  import alternativa.tanks.models.battle.gui.chat.ChatLocker;
  import alternativa.tanks.models.battle.gui.chat.IBattleChat;
  import alternativa.tanks.models.battle.gui.chat.IBattleChatAdapt;
  import alternativa.tanks.models.battle.gui.chat.IBattleChatEvents;
  import alternativa.tanks.models.battle.gui.chat.cmdhandlers.BlockCommandHandler;
  import alternativa.tanks.models.battle.gui.chat.cmdhandlers.UnblockCommandHandler;
  import alternativa.tanks.models.battle.gui.drone.DroneIndicatorModel;
  import alternativa.tanks.models.battle.gui.drone.IDroneModel;
  import alternativa.tanks.models.battle.gui.drone.IDroneModelAdapt;
  import alternativa.tanks.models.battle.gui.drone.IDroneModelEvents;
  import alternativa.tanks.models.battle.gui.group.MatchmakingGroupInfoModel;
  import alternativa.tanks.models.battle.gui.gui.help.ControlsHelper;
  import alternativa.tanks.models.battle.gui.gui.help.ControlsMiniHelp;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.fund.FundField;
  import alternativa.tanks.models.battle.gui.gui.statistics.fps.FPSText;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.BattleMessages;
  import alternativa.tanks.models.battle.gui.gui.statistics.table.StatisticsListRenderer;
  import alternativa.tanks.models.battle.gui.gui.statistics.table.StatisticsTable;
  import alternativa.tanks.models.battle.gui.gui.statistics.table.ViewStatistics;
  import alternativa.tanks.models.battle.gui.indicators.ReloaderIndicator;
  import alternativa.tanks.models.battle.gui.indicators.SuicideIndicator;
  import alternativa.tanks.models.battle.gui.indicators.TurnOverIndicator;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryItem;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryItemAdapt;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryItemEvents;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
  import alternativa.tanks.models.battle.gui.inventory.InventoryItemModel;
  import alternativa.tanks.models.battle.gui.inventory.InventoryModel;
  import alternativa.tanks.models.battle.gui.inventory.InventoryPanelSlot;
  import alternativa.tanks.models.battle.gui.inventory.InventorySfxModel;
  import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
  import alternativa.tanks.models.battle.gui.inventory.cooldown.InventoryCooldownModel;
  import alternativa.tanks.models.battle.gui.markers.PointMarker;
  import alternativa.tanks.models.battle.gui.statistics.DefaultLayout;
  import alternativa.tanks.models.battle.gui.ultimate.UltimateIndicator;
  import alternativa.tanks.models.battle.gui.userlabel.BattleChatUserLabel;
  import alternativa.tanks.models.battle.jgr.BattleJGRModel;
  import alternativa.tanks.models.battle.jgr.Juggernaut;
  import alternativa.tanks.models.battle.jgr.JuggernautAdapt;
  import alternativa.tanks.models.battle.jgr.JuggernautEvents;
  import alternativa.tanks.models.battle.jgr.JuggernautHudIndicator;
  import alternativa.tanks.models.battle.jgr.JuggernautModel;
  import alternativa.tanks.models.battle.jgr.killstreak.KillStreakModel;
  import alternativa.tanks.models.battle.meteor.MeteorStormModel;
  import alternativa.tanks.models.battle.rugby.Ball;
  import alternativa.tanks.models.battle.rugby.RugbyMessages;
  import alternativa.tanks.models.battle.rugby.RugbyModel;
  import alternativa.tanks.models.battle.rugby.explosion.BallExplosion;
  import alternativa.tanks.models.battle.rugby.explosion.BallExplosionAdapt;
  import alternativa.tanks.models.battle.rugby.explosion.BallExplosionEvents;
  import alternativa.tanks.models.battle.rugby.explosion.BallExplosionModel;
  import alternativa.tanks.models.battle.statistics.MemoryStatisticsModel;
  import alternativa.tanks.models.battle.statistics.fps.CameraStatisticFeature;
  import alternativa.tanks.models.battle.statistics.fps.FpsStatisticsModel;
  import alternativa.tanks.models.battle.statistics.targetingmode.TargetingStatisticsModel;
  import alternativa.tanks.models.battle.tdm.BattleTDMModel;
  import alternativa.tanks.models.bonus.battlefield.BattlefieldBonusesModel;
  import alternativa.tanks.models.bonus.bonuslight.BonusLightModel;
  import alternativa.tanks.models.bonus.bonuslight.IBonusLight;
  import alternativa.tanks.models.bonus.bonuslight.IBonusLightAdapt;
  import alternativa.tanks.models.bonus.bonuslight.IBonusLightEvents;
  import alternativa.tanks.models.bonus.common.BonusCommonModel;
  import alternativa.tanks.models.bonus.gold.BattleGoldBonusesModel;
  import alternativa.tanks.models.bonus.goldbonus.GoldBonusesModel;
  import alternativa.tanks.models.bonus.goldbonus.IGoldBonus;
  import alternativa.tanks.models.bonus.goldbonus.IGoldBonusAdapt;
  import alternativa.tanks.models.bonus.goldbonus.IGoldBonusEvents;
  import alternativa.tanks.models.bonus.notification.BonusNotification;
  import alternativa.tanks.models.bonus.notification.BonusNotificationAdapt;
  import alternativa.tanks.models.bonus.notification.BonusNotificationEvents;
  import alternativa.tanks.models.bonus.notification.BonusNotificationModel;
  import alternativa.tanks.models.bonus.notification.RandomGoldBonusTakeModel;
  import alternativa.tanks.models.bonus.region.BonusRegion;
  import alternativa.tanks.models.bonus.region.BonusRegionsModel;
  import alternativa.tanks.models.coloradjust.ColorAdjustModel;
  import alternativa.tanks.models.coloradjust.IColorAdjust;
  import alternativa.tanks.models.coloradjust.IColorAdjustAdapt;
  import alternativa.tanks.models.coloradjust.IColorAdjustEvents;
  import alternativa.tanks.models.continuebattle.ContinueBattle;
  import alternativa.tanks.models.continuebattle.ContinueBattleAdapt;
  import alternativa.tanks.models.continuebattle.ContinueBattleEvents;
  import alternativa.tanks.models.continuebattle.ContinueBattleModel;
  import alternativa.tanks.models.continuebattle.MatchmakingContinueBattleModel;
  import alternativa.tanks.models.controlpoints.ControlPointsModel;
  import alternativa.tanks.models.controlpoints.hud.KeyPointView;
  import alternativa.tanks.models.controlpoints.hud.marker.KeyPointHUDMarkers;
  import alternativa.tanks.models.controlpoints.message.ControlPointMessage;
  import alternativa.tanks.models.controlpoints.sfx.BeamEffects;
  import alternativa.tanks.models.drones.DroneEffects;
  import alternativa.tanks.models.drones.DroneMaterialFactory;
  import alternativa.tanks.models.effects.activeafetrdeath.ActiveAfterDeathModel;
  import alternativa.tanks.models.effects.activeafetrdeath.IActiveAfterDeath;
  import alternativa.tanks.models.effects.activeafetrdeath.IActiveAfterDeathAdapt;
  import alternativa.tanks.models.effects.activeafetrdeath.IActiveAfterDeathEvents;
  import alternativa.tanks.models.effects.common.IBonusCommonModel;
  import alternativa.tanks.models.effects.common.IBonusCommonModelAdapt;
  import alternativa.tanks.models.effects.common.IBonusCommonModelEvents;
  import alternativa.tanks.models.effects.description.EffectDescriptionModel;
  import alternativa.tanks.models.effects.durationTime.DurationModel;
  import alternativa.tanks.models.effects.durationTime.IDuration;
  import alternativa.tanks.models.effects.durationTime.IDurationAdapt;
  import alternativa.tanks.models.effects.durationTime.IDurationEvents;
  import alternativa.tanks.models.effects.effectlevel.EffectLevelModel;
  import alternativa.tanks.models.effects.effectlevel.IEffectLevel;
  import alternativa.tanks.models.effects.effectlevel.IEffectLevelAdapt;
  import alternativa.tanks.models.effects.effectlevel.IEffectLevelEvents;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.IInventoryModelAdapt;
  import alternativa.tanks.models.inventory.IInventoryModelEvents;
  import alternativa.tanks.models.latency.LatencyModel;
  import alternativa.tanks.models.map.BattleMapModel;
  import alternativa.tanks.models.map.IBattleMap;
  import alternativa.tanks.models.map.IBattleMapAdapt;
  import alternativa.tanks.models.map.IBattleMapEvents;
  import alternativa.tanks.models.mapbonuslight.IMapBonusLight;
  import alternativa.tanks.models.mapbonuslight.IMapBonusLightAdapt;
  import alternativa.tanks.models.mapbonuslight.IMapBonusLightEvents;
  import alternativa.tanks.models.mapbonuslight.MapBonusLightModel;
  import alternativa.tanks.models.performance.PerformanceModel;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformConsumer;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformConsumerAdapt;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformConsumerEvents;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformModel;
  import alternativa.tanks.models.sfx.effectsfx.TankEffectSFXModel;
  import alternativa.tanks.models.sfx.smoke.HullSmoke;
  import alternativa.tanks.models.sfx.smoke.HullSmokeAdapt;
  import alternativa.tanks.models.sfx.smoke.HullSmokeEvents;
  import alternativa.tanks.models.sfx.smoke.HullSmokeModel;
  import alternativa.tanks.models.sfx.smoke.HullSmokeRenderer;
  import alternativa.tanks.models.statistics.BattlefieldMessagesAligner;
  import alternativa.tanks.models.statistics.ControlsHelpSupport;
  import alternativa.tanks.models.statistics.ControlsMiniHelpSupport;
  import alternativa.tanks.models.statistics.FpsIndicatorToggleSupport;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import alternativa.tanks.models.statistics.IClientUserInfoAdapt;
  import alternativa.tanks.models.statistics.IClientUserInfoEvents;
  import alternativa.tanks.models.statistics.IStatisticRound;
  import alternativa.tanks.models.statistics.IStatisticRoundAdapt;
  import alternativa.tanks.models.statistics.IStatisticRoundEvents;
  import alternativa.tanks.models.statistics.IStatisticsModel;
  import alternativa.tanks.models.statistics.IStatisticsModelAdapt;
  import alternativa.tanks.models.statistics.IStatisticsModelEvents;
  import alternativa.tanks.models.statistics.PauseIndicatorSupport;
  import alternativa.tanks.models.statistics.SpectatorScreenLayouts;
  import alternativa.tanks.models.statistics.StatisticsModel;
  import alternativa.tanks.models.statistics.TankKillLogger;
  import alternativa.tanks.models.statistics.dm.StatisticsDmModel;
  import alternativa.tanks.models.statistics.team.StatisticsTeamModel;
  import alternativa.tanks.models.tank.AddToBattleListener;
  import alternativa.tanks.models.tank.AddToBattleListenerAdapt;
  import alternativa.tanks.models.tank.AddToBattleListenerEvents;
  import alternativa.tanks.models.tank.ChassisStateCorrectionTask;
  import alternativa.tanks.models.tank.DestroyTankPart;
  import alternativa.tanks.models.tank.DestroyTankPartAdapt;
  import alternativa.tanks.models.tank.DestroyTankPartEvents;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ITankModelAdapt;
  import alternativa.tanks.models.tank.ITankModelEvents;
  import alternativa.tanks.models.tank.InitTankPart;
  import alternativa.tanks.models.tank.InitTankPartAdapt;
  import alternativa.tanks.models.tank.InitTankPartEvents;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.LocalWeaponController;
  import alternativa.tanks.models.tank.MainLoopExecutionErrorHandler;
  import alternativa.tanks.models.tank.PositionBookmarks;
  import alternativa.tanks.models.tank.RegularUserTitleRenderer;
  import alternativa.tanks.models.tank.RemoveFromBattleListener;
  import alternativa.tanks.models.tank.RemoveFromBattleListenerAdapt;
  import alternativa.tanks.models.tank.RemoveFromBattleListenerEvents;
  import alternativa.tanks.models.tank.SpawnCameraConfigurator;
  import alternativa.tanks.models.tank.TankDataValidatorWrapper;
  import alternativa.tanks.models.tank.TankModel;
  import alternativa.tanks.models.tank.TankPartReset;
  import alternativa.tanks.models.tank.TankPartResetAdapt;
  import alternativa.tanks.models.tank.TankPartResetEvents;
  import alternativa.tanks.models.tank.TankUserInfoUpdater;
  import alternativa.tanks.models.tank.WeaponMountProvider;
  import alternativa.tanks.models.tank.WeaponMountProviderAdapt;
  import alternativa.tanks.models.tank.WeaponMountProviderEvents;
  import alternativa.tanks.models.tank.armor.Armor;
  import alternativa.tanks.models.tank.armor.ArmorAdapt;
  import alternativa.tanks.models.tank.armor.ArmorEvents;
  import alternativa.tanks.models.tank.armor.SimpleArmorModel;
  import alternativa.tanks.models.tank.armor.chassis.tracked.ITrackedChassis;
  import alternativa.tanks.models.tank.armor.chassis.tracked.ITrackedChassisAdapt;
  import alternativa.tanks.models.tank.armor.chassis.tracked.ITrackedChassisEvents;
  import alternativa.tanks.models.tank.armor.chassis.tracked.TrackedChassisModel;
  import alternativa.tanks.models.tank.bosstate.BossStateModel;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import alternativa.tanks.models.tank.bosstate.IBossStateAdapt;
  import alternativa.tanks.models.tank.bosstate.IBossStateEvents;
  import alternativa.tanks.models.tank.configuration.TankConfiguration;
  import alternativa.tanks.models.tank.configuration.TankConfigurationAdapt;
  import alternativa.tanks.models.tank.configuration.TankConfigurationEvents;
  import alternativa.tanks.models.tank.configuration.TankConfigurationModel;
  import alternativa.tanks.models.tank.damageindicator.DamageIndicatorModel;
  import alternativa.tanks.models.tank.device.TankDevice;
  import alternativa.tanks.models.tank.device.TankDeviceAdapt;
  import alternativa.tanks.models.tank.device.TankDeviceEvents;
  import alternativa.tanks.models.tank.device.TankDeviceModel;
  import alternativa.tanks.models.tank.engine.Engine;
  import alternativa.tanks.models.tank.engine.EngineAdapt;
  import alternativa.tanks.models.tank.engine.EngineEvents;
  import alternativa.tanks.models.tank.engine.EngineModel;
  import alternativa.tanks.models.tank.event.LocalTankLoadListener;
  import alternativa.tanks.models.tank.event.LocalTankLoadListenerAdapt;
  import alternativa.tanks.models.tank.event.LocalTankLoadListenerEvents;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListenerAdapt;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListenerEvents;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import alternativa.tanks.models.tank.event.TankEntityCreationListenerAdapt;
  import alternativa.tanks.models.tank.event.TankEntityCreationListenerEvents;
  import alternativa.tanks.models.tank.explosion.ITankExplosionModel;
  import alternativa.tanks.models.tank.explosion.ITankExplosionModelAdapt;
  import alternativa.tanks.models.tank.explosion.ITankExplosionModelEvents;
  import alternativa.tanks.models.tank.explosion.TankExplosionModel;
  import alternativa.tanks.models.tank.gearscore.BattleGearScoreModel;
  import alternativa.tanks.models.tank.gearscore.GearScoreInfo;
  import alternativa.tanks.models.tank.gearscore.GearScoreInfoAdapt;
  import alternativa.tanks.models.tank.gearscore.GearScoreInfoEvents;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.models.tank.hullcommon.HullCommonAdapt;
  import alternativa.tanks.models.tank.hullcommon.HullCommonEvents;
  import alternativa.tanks.models.tank.hullcommon.HullCommonModel;
  import alternativa.tanks.models.tank.killhandlers.CommonTankDieHandler;
  import alternativa.tanks.models.tank.killhandlers.DeathConfirmationTimeoutTask;
  import alternativa.tanks.models.tank.pause.ITankPause;
  import alternativa.tanks.models.tank.pause.ITankPauseAdapt;
  import alternativa.tanks.models.tank.pause.ITankPauseEvents;
  import alternativa.tanks.models.tank.pause.TankPauseModel;
  import alternativa.tanks.models.tank.rankup.ITankRankUpEffectModel;
  import alternativa.tanks.models.tank.rankup.ITankRankUpEffectModelAdapt;
  import alternativa.tanks.models.tank.rankup.ITankRankUpEffectModelEvents;
  import alternativa.tanks.models.tank.rankup.RankChangeListener;
  import alternativa.tanks.models.tank.rankup.ScheduledTankRankChangeEffect;
  import alternativa.tanks.models.tank.rankup.TankRankUpEffectModel;
  import alternativa.tanks.models.tank.reloader.TankReloaderModel;
  import alternativa.tanks.models.tank.resistance.TankResistances;
  import alternativa.tanks.models.tank.resistance.TankResistancesAdapt;
  import alternativa.tanks.models.tank.resistance.TankResistancesEvents;
  import alternativa.tanks.models.tank.resistance.TankResistancesModel;
  import alternativa.tanks.models.tank.spawn.ITankSpawner;
  import alternativa.tanks.models.tank.spawn.ITankSpawnerAdapt;
  import alternativa.tanks.models.tank.spawn.ITankSpawnerEvents;
  import alternativa.tanks.models.tank.spawn.ReadyToPlaceTask;
  import alternativa.tanks.models.tank.spawn.ReadyToSpawnTask;
  import alternativa.tanks.models.tank.spawn.TankSpawnerModel;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.LocalTankFirstTimeSpawner;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.LocalReadyToSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.LocalSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.SpectatorSpawnHandler;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristicsAdapt;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristicsEvents;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristicsModel;
  import alternativa.tanks.models.tank.suicude.SuicideModel;
  import alternativa.tanks.models.tank.support.AutoExitSupport;
  import alternativa.tanks.models.tank.support.ClientDeactivationSupport;
  import alternativa.tanks.models.tank.support.DialogWindowSupport;
  import alternativa.tanks.models.tank.support.PauseSupport;
  import alternativa.tanks.models.tank.support.StateCorrectionSupport;
  import alternativa.tanks.models.tank.support.SuicideSupport;
  import alternativa.tanks.models.tank.support.TankReloaderSupport;
  import alternativa.tanks.models.tank.support.TankSettingsSupport;
  import alternativa.tanks.models.tank.support.TurnOverIndicatorSupport;
  import alternativa.tanks.models.tank.temperature.TankTemperatureModel;
  import alternativa.tanks.models.tank.turnover.TankTurnOverModel;
  import alternativa.tanks.models.tank.ultimate.IUltimateModel;
  import alternativa.tanks.models.tank.ultimate.IUltimateModelAdapt;
  import alternativa.tanks.models.tank.ultimate.IUltimateModelEvents;
  import alternativa.tanks.models.tank.ultimate.UltimateModel;
  import alternativa.tanks.models.tank.ultimate.dictator.DictatorUltimateModel;
  import alternativa.tanks.models.tank.ultimate.hornet.HornetUltimateModel;
  import alternativa.tanks.models.tank.ultimate.hornet.radar.BattleRadarHudIndicators;
  import alternativa.tanks.models.tank.ultimate.hornet.radar.BattleUltimateRadarModel;
  import alternativa.tanks.models.tank.ultimate.hunter.HunterUltimateModel;
  import alternativa.tanks.models.tank.ultimate.hunter.TankStunModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListenerAdapt;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListenerEvents;
  import alternativa.tanks.models.tank.ultimate.juggernaut.JuggernautUltimateModel;
  import alternativa.tanks.models.tank.ultimate.mammoth.ImpactEnable;
  import alternativa.tanks.models.tank.ultimate.mammoth.ImpactEnableAdapt;
  import alternativa.tanks.models.tank.ultimate.mammoth.ImpactEnableEvents;
  import alternativa.tanks.models.tank.ultimate.mammoth.MammothUltimateModel;
  import alternativa.tanks.models.tank.ultimate.titan.generator.TitanUltimateGeneratorModel;
  import alternativa.tanks.models.tank.ultimate.viking.VikingUltimateModel;
  import alternativa.tanks.models.tank.ultimate.wasp.bomb.WaspUltimateBombModel;
  import alternativa.tanks.models.teamlight.IModeLight;
  import alternativa.tanks.models.teamlight.IModeLightAdapt;
  import alternativa.tanks.models.teamlight.IModeLightEvents;
  import alternativa.tanks.models.teamlight.TeamLightModel;
  import alternativa.tanks.models.timechecker.TimeCheckerModel;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.IWeaponModelAdapt;
  import alternativa.tanks.models.weapon.IWeaponModelEvents;
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAngles;
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAnglesAdapt;
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAnglesEvents;
  import alternativa.tanks.models.weapon.angles.verticals.WeaponVerticalAnglesModel;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAimingAdapt;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAimingEvents;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAimingModel;
  import alternativa.tanks.models.weapon.artillery.ArtilleryCannonEffect;
  import alternativa.tanks.models.weapon.artillery.ArtilleryEffectsProvider;
  import alternativa.tanks.models.weapon.artillery.ArtilleryEffectsProviderAdapt;
  import alternativa.tanks.models.weapon.artillery.ArtilleryEffectsProviderEvents;
  import alternativa.tanks.models.weapon.artillery.ArtilleryModel;
  import alternativa.tanks.models.weapon.artillery.ArtilleryShell;
  import alternativa.tanks.models.weapon.artillery.ArtillerySkin;
  import alternativa.tanks.models.weapon.artillery.ArtillerySkinAdapt;
  import alternativa.tanks.models.weapon.artillery.ArtillerySkinEvents;
  import alternativa.tanks.models.weapon.artillery.ArtilleryVariant;
  import alternativa.tanks.models.weapon.artillery.ArtilleryVariantAdapt;
  import alternativa.tanks.models.weapon.artillery.ArtilleryVariantEvents;
  import alternativa.tanks.models.weapon.artillery.IArtilleryModel;
  import alternativa.tanks.models.weapon.artillery.IArtilleryModelAdapt;
  import alternativa.tanks.models.weapon.artillery.IArtilleryModelEvents;
  import alternativa.tanks.models.weapon.artillery.VerticalAngleView;
  import alternativa.tanks.models.weapon.artillery.rotation.ArtilleryElevatingBarrelModel;
  import alternativa.tanks.models.weapon.artillery.rotation.ArtilleryRotatingTurretModel;
  import alternativa.tanks.models.weapon.artillery.rotation.BarrelElevationController;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryFlame;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfx;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxAdapt;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxData;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxEvents;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxModel;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryShellEffects;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryShotEffect;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryTrailEffect;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModelAdapt;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModelEvents;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.common.WeaponBuffListenerAdapt;
  import alternativa.tanks.models.weapon.common.WeaponBuffListenerEvents;
  import alternativa.tanks.models.weapon.common.WeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponSound;
  import alternativa.tanks.models.weapon.common.WeaponSoundAdapt;
  import alternativa.tanks.models.weapon.common.WeaponSoundEvents;
  import alternativa.tanks.models.weapon.flamethrower.FlamethrowerEffects;
  import alternativa.tanks.models.weapon.flamethrower.FlamethrowerModel;
  import alternativa.tanks.models.weapon.flamethrower.FlamethrowerSFXModel;
  import alternativa.tanks.models.weapon.flamethrower.IFlamethrowerSFXModel;
  import alternativa.tanks.models.weapon.flamethrower.IFlamethrowerSFXModelAdapt;
  import alternativa.tanks.models.weapon.flamethrower.IFlamethrowerSFXModelEvents;
  import alternativa.tanks.models.weapon.freeze.FreezeModel;
  import alternativa.tanks.models.weapon.freeze.FreezeSFXModel;
  import alternativa.tanks.models.weapon.freeze.IFreezeSFXModel;
  import alternativa.tanks.models.weapon.freeze.IFreezeSFXModelAdapt;
  import alternativa.tanks.models.weapon.freeze.IFreezeSFXModelEvents;
  import alternativa.tanks.models.weapon.gauss.CommonGaussWeapon;
  import alternativa.tanks.models.weapon.gauss.GaussModel;
  import alternativa.tanks.models.weapon.gauss.GaussSkin;
  import alternativa.tanks.models.weapon.gauss.GaussSkinAdapt;
  import alternativa.tanks.models.weapon.gauss.GaussSkinEvents;
  import alternativa.tanks.models.weapon.gauss.GaussWeaponCallback;
  import alternativa.tanks.models.weapon.gauss.GaussWeaponCallbackAdapt;
  import alternativa.tanks.models.weapon.gauss.GaussWeaponCallbackEvents;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussAntennaAimingEffect;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussEffects;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussMuzzleEffect;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussPowerShotEffect;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussSFXModel;
  import alternativa.tanks.models.weapon.gauss.sfx.IGaussSFXModel;
  import alternativa.tanks.models.weapon.gauss.sfx.IGaussSFXModelAdapt;
  import alternativa.tanks.models.weapon.gauss.sfx.IGaussSFXModelEvents;
  import alternativa.tanks.models.weapon.healing.HealingGunCallback;
  import alternativa.tanks.models.weapon.healing.HealingGunCallbackAdapt;
  import alternativa.tanks.models.weapon.healing.HealingGunCallbackEvents;
  import alternativa.tanks.models.weapon.healing.HealingGunModel;
  import alternativa.tanks.models.weapon.healing.HealingGunSFXModel;
  import alternativa.tanks.models.weapon.healing.IHealingGunSFXModel;
  import alternativa.tanks.models.weapon.healing.IHealingGunSFXModelAdapt;
  import alternativa.tanks.models.weapon.healing.IHealingGunSFXModelEvents;
  import alternativa.tanks.models.weapon.healing.targeting.IsisTargetPriorityCalculator;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.models.weapon.laser.LaserPointerAdapt;
  import alternativa.tanks.models.weapon.laser.LaserPointerEffect;
  import alternativa.tanks.models.weapon.laser.LaserPointerEvents;
  import alternativa.tanks.models.weapon.laser.LaserPointerModel;
  import alternativa.tanks.models.weapon.machinegun.MachineGunCommonWeapon;
  import alternativa.tanks.models.weapon.machinegun.MachineGunModel;
  import alternativa.tanks.models.weapon.machinegun.MachineGunRemoteWeapon;
  import alternativa.tanks.models.weapon.machinegun.MachineGunWeapon;
  import alternativa.tanks.models.weapon.machinegun.sfx.IMachineGunSFXModel;
  import alternativa.tanks.models.weapon.machinegun.sfx.IMachineGunSFXModelAdapt;
  import alternativa.tanks.models.weapon.machinegun.sfx.IMachineGunSFXModelEvents;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunEffects;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXModel;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunShotEffect;
  import alternativa.tanks.models.weapon.machinegun.sfx.ParticleSystem;
  import alternativa.tanks.models.weapon.machinegun.sfx.sound.MachineGunSoundManager;
  import alternativa.tanks.models.weapon.railgun.IRailgunSFXModel;
  import alternativa.tanks.models.weapon.railgun.IRailgunSFXModelAdapt;
  import alternativa.tanks.models.weapon.railgun.IRailgunSFXModelEvents;
  import alternativa.tanks.models.weapon.railgun.RailgunCallback;
  import alternativa.tanks.models.weapon.railgun.RailgunCallbackAdapt;
  import alternativa.tanks.models.weapon.railgun.RailgunCallbackEvents;
  import alternativa.tanks.models.weapon.railgun.RailgunModel;
  import alternativa.tanks.models.weapon.railgun.RailgunSFXModel;
  import alternativa.tanks.models.weapon.ricochet.IRicochetSFXModel;
  import alternativa.tanks.models.weapon.ricochet.IRicochetSFXModelAdapt;
  import alternativa.tanks.models.weapon.ricochet.IRicochetSFXModelEvents;
  import alternativa.tanks.models.weapon.ricochet.RicochetAmmunition;
  import alternativa.tanks.models.weapon.ricochet.RicochetModel;
  import alternativa.tanks.models.weapon.ricochet.RicochetSFXModel;
  import alternativa.tanks.models.weapon.ricochet.RicochetWeapon;
  import alternativa.tanks.models.weapon.ricochet.RicochetWeaponCallback;
  import alternativa.tanks.models.weapon.ricochet.RicochetWeaponCallbackAdapt;
  import alternativa.tanks.models.weapon.ricochet.RicochetWeaponCallbackEvents;
  import alternativa.tanks.models.weapon.rocketlauncher.RocketLauncherModel;
  import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplosion;
  import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplosionAdapt;
  import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplosionEvents;
  import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketLauncherRadioExplosionModel;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketFlightEffect;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfx;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfxAdapt;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfxData;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfxEvents;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherSfxModel;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketSmoke;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RemoteRocketLauncherWeapon;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeapon;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponProvider;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponProviderAdapt;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponProviderEvents;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.RocketLauncherAim;
  import alternativa.tanks.models.weapon.rotation.WeaponRotationLimit;
  import alternativa.tanks.models.weapon.rotation.WeaponRotationLimitAdapt;
  import alternativa.tanks.models.weapon.rotation.WeaponRotationLimitEvents;
  import alternativa.tanks.models.weapon.rotation.WeaponRotationLimitModel;
  import alternativa.tanks.models.weapon.shaft.IShaftSFXModel;
  import alternativa.tanks.models.weapon.shaft.IShaftSFXModelAdapt;
  import alternativa.tanks.models.weapon.shaft.IShaftSFXModelEvents;
  import alternativa.tanks.models.weapon.shaft.IShaftWeaponCallback;
  import alternativa.tanks.models.weapon.shaft.IShaftWeaponCallbackAdapt;
  import alternativa.tanks.models.weapon.shaft.IShaftWeaponCallbackEvents;
  import alternativa.tanks.models.weapon.shaft.ReticleDisplay;
  import alternativa.tanks.models.weapon.shaft.ShaftModel;
  import alternativa.tanks.models.weapon.shaft.ShaftSFXModel;
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;
  import alternativa.tanks.models.weapon.shaft.cameracontrollers.AimingCameraController;
  import alternativa.tanks.models.weapon.shared.MarginalCollider;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapon.shared.shot.DiscreteShotModel;
  import alternativa.tanks.models.weapon.shared.shot.IShotModel;
  import alternativa.tanks.models.weapon.shared.shot.IShotModelAdapt;
  import alternativa.tanks.models.weapon.shared.shot.IShotModelEvents;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListenerAdapt;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListenerEvents;
  import alternativa.tanks.models.weapon.shared.streamweapon.IStreamWeaponCallback;
  import alternativa.tanks.models.weapon.shared.streamweapon.IStreamWeaponCallbackAdapt;
  import alternativa.tanks.models.weapon.shared.streamweapon.IStreamWeaponCallbackEvents;
  import alternativa.tanks.models.weapon.shotgun.ShotgunModel;
  import alternativa.tanks.models.weapon.shotgun.ShotgunRicochetTargetingSystem;
  import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAiming;
  import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAimingAdapt;
  import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAimingEvents;
  import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAimingModel;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunEffects;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFX;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFXAdapt;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFXData;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFXEvents;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFXModel;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunShotEffect;
  import alternativa.tanks.models.weapon.smoky.SmokyCallback;
  import alternativa.tanks.models.weapon.smoky.SmokyCallbackAdapt;
  import alternativa.tanks.models.weapon.smoky.SmokyCallbackEvents;
  import alternativa.tanks.models.weapon.smoky.SmokyModel;
  import alternativa.tanks.models.weapon.smoky.sfx.ISmokySFXModel;
  import alternativa.tanks.models.weapon.smoky.sfx.ISmokySFXModelAdapt;
  import alternativa.tanks.models.weapon.smoky.sfx.ISmokySFXModelEvents;
  import alternativa.tanks.models.weapon.smoky.sfx.SmokyEffects;
  import alternativa.tanks.models.weapon.smoky.sfx.SmokySFXModel;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.splash.SplashAdapt;
  import alternativa.tanks.models.weapon.splash.SplashEvents;
  import alternativa.tanks.models.weapon.splash.SplashModel;
  import alternativa.tanks.models.weapon.streamweapon.IStreamWeaponModel;
  import alternativa.tanks.models.weapon.streamweapon.IStreamWeaponModelAdapt;
  import alternativa.tanks.models.weapon.streamweapon.IStreamWeaponModelEvents;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponModel;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponReconfiguredListener;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponReconfiguredListenerAdapt;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponReconfiguredListenerEvents;
  import alternativa.tanks.models.weapon.terminator.RemoteTerminatorWeapon;
  import alternativa.tanks.models.weapon.terminator.Terminator;
  import alternativa.tanks.models.weapon.terminator.TerminatorAdapt;
  import alternativa.tanks.models.weapon.terminator.TerminatorEvents;
  import alternativa.tanks.models.weapon.terminator.TerminatorModel;
  import alternativa.tanks.models.weapon.terminator.TerminatorSkin;
  import alternativa.tanks.models.weapon.terminator.TerminatorSkinAdapt;
  import alternativa.tanks.models.weapon.terminator.TerminatorSkinEvents;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorEffects;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorOpenEffect;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorRecoilEffect;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorSFX;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorSFXAdapt;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorSFXEvents;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorSFXModel;
  import alternativa.tanks.models.weapon.thunder.IThunderSFXModel;
  import alternativa.tanks.models.weapon.thunder.IThunderSFXModelAdapt;
  import alternativa.tanks.models.weapon.thunder.IThunderSFXModelEvents;
  import alternativa.tanks.models.weapon.thunder.ThunderCallback;
  import alternativa.tanks.models.weapon.thunder.ThunderCallbackAdapt;
  import alternativa.tanks.models.weapon.thunder.ThunderCallbackEvents;
  import alternativa.tanks.models.weapon.thunder.ThunderModel;
  import alternativa.tanks.models.weapon.thunder.ThunderSFXModel;
  import alternativa.tanks.models.weapon.turret.IRotatingTurretModel;
  import alternativa.tanks.models.weapon.turret.IRotatingTurretModelAdapt;
  import alternativa.tanks.models.weapon.turret.IRotatingTurretModelEvents;
  import alternativa.tanks.models.weapon.turret.RotatingTurretModel;
  import alternativa.tanks.models.weapon.turret.TurretStateSender;
  import alternativa.tanks.models.weapon.turret.TurretStateSenderAdapt;
  import alternativa.tanks.models.weapon.turret.TurretStateSenderEvents;
  import alternativa.tanks.models.weapon.twins.ITwinsSFXModel;
  import alternativa.tanks.models.weapon.twins.ITwinsSFXModelAdapt;
  import alternativa.tanks.models.weapon.twins.ITwinsSFXModelEvents;
  import alternativa.tanks.models.weapon.twins.TwinsAmmunition;
  import alternativa.tanks.models.weapon.twins.TwinsModel;
  import alternativa.tanks.models.weapon.twins.TwinsSFXModel;
  import alternativa.tanks.models.weapon.twins.TwinsWeaponCallback;
  import alternativa.tanks.models.weapon.twins.TwinsWeaponCallbackAdapt;
  import alternativa.tanks.models.weapon.twins.TwinsWeaponCallbackEvents;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModelAdapt;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModelEvents;
  import alternativa.tanks.models.weapon.weakening.WeaponWeakeningModel;
  import alternativa.tanks.models.weapons.charging.WeaponChargingCommunication;
  import alternativa.tanks.models.weapons.charging.WeaponChargingCommunicationAdapt;
  import alternativa.tanks.models.weapons.charging.WeaponChargingCommunicationEvents;
  import alternativa.tanks.models.weapons.charging.WeaponChargingCommunicationModel;
  import alternativa.tanks.models.weapons.charging.WeaponChargingListener;
  import alternativa.tanks.models.weapons.charging.WeaponChargingListenerAdapt;
  import alternativa.tanks.models.weapons.charging.WeaponChargingListenerEvents;
  import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeapon;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponAdapt;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponCommunicationModel;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponEvents;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponListener;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponListenerAdapt;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponListenerEvents;
  import alternativa.tanks.models.weapons.shell.Shell;
  import alternativa.tanks.models.weapons.shell.ShellWeaponCommunication;
  import alternativa.tanks.models.weapons.shell.ShellWeaponCommunicationAdapt;
  import alternativa.tanks.models.weapons.shell.ShellWeaponCommunicationEvents;
  import alternativa.tanks.models.weapons.shell.ShellWeaponCommunicationModel;
  import alternativa.tanks.models.weapons.shell.ShellWeaponListener;
  import alternativa.tanks.models.weapons.shell.ShellWeaponListenerAdapt;
  import alternativa.tanks.models.weapons.shell.ShellWeaponListenerEvents;
  import alternativa.tanks.models.weapons.shell.TargetShellWeaponListener;
  import alternativa.tanks.models.weapons.shell.TargetShellWeaponListenerAdapt;
  import alternativa.tanks.models.weapons.shell.TargetShellWeaponListenerEvents;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;
  import alternativa.tanks.models.weapons.stream.StreamWeaponCommunication;
  import alternativa.tanks.models.weapons.stream.StreamWeaponCommunicationAdapt;
  import alternativa.tanks.models.weapons.stream.StreamWeaponCommunicationEvents;
  import alternativa.tanks.models.weapons.stream.StreamWeaponCommunicationModel;
  import alternativa.tanks.models.weapons.stream.StreamWeaponListener;
  import alternativa.tanks.models.weapons.stream.StreamWeaponListenerAdapt;
  import alternativa.tanks.models.weapons.stream.StreamWeaponListenerEvents;
  import alternativa.tanks.models.weapons.targeting.debug.TargetingVisualDebug;
  import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSectorsCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.CommonTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.PenetratingTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.ShaftTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.CommonDirectionProcessor;
  import alternativa.tanks.models.weapons.targeting.processor.DirectionProcessorForPenetratingWeapons;
  import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
  import alternativa.tanks.models.weapons.targeting.processor.SingleTargetPrecisionDirectionProcessor;
  import alternativa.tanks.physics.SoaringChecker;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battlegui.BattleGUIServiceImpl;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.BattleInputServiceImpl;
  import alternativa.tanks.services.battlereadiness.BattleReadinessService;
  import alternativa.tanks.services.battlereadiness.BattleReadinessServiceImpl;
  import alternativa.tanks.services.bonusregion.BonusRegionService;
  import alternativa.tanks.services.bonusregion.IBonusRegionService;
  import alternativa.tanks.services.colortransform.ColorTransformService;
  import alternativa.tanks.services.initialeffects.IInitialEffectsService;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.tanks.services.memoryleakguard.MemoryLeakTrackerService;
  import alternativa.tanks.services.mipmapping.MipMappingService;
  import alternativa.tanks.services.performance.PerformanceDataService;
  import alternativa.tanks.services.ping.PingService;
  import alternativa.tanks.services.spectatorservice.SpectatorService;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.tanks.sfx.BonusCrystalsEffectUtils;
  import alternativa.tanks.sfx.DecalEffect;
  import alternativa.tanks.sfx.LevelUpEffectFactory;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.damageindicator.DamageIndicatorEffect;
  import alternativa.tanks.sfx.drone.DroneExplosionModel;
  import alternativa.tanks.sfx.drone.DroneSFX;
  import alternativa.tanks.sfx.drone.DroneSFXAdapt;
  import alternativa.tanks.sfx.drone.DroneSFXEvents;
  import alternativa.tanks.sfx.drone.DroneSFXModel;
  import alternativa.tanks.sfx.floatingmessage.FloatingTextEffect;
  import alternativa.tanks.utils.DataValidator;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.flash.commons.services.autobattleenter.AutomaticEnterExitService;
  import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.group.IGroupInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
  import services.contextmenu.IContextMenuService;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegisterAdapt:ModelRegistry;
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleRunner.battleService = BattleService(param1);
      },function():BattleService {
        return BattleRunner.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        BattleRunner.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return BattleRunner.localTankInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleRunnerProvider.battleService = BattleService(param1);
      },function():BattleService {
        return BattleRunnerProvider.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleUtils.battleService = BattleService(param1);
      },function():BattleService {
        return BattleUtils.battleService;
      });
      osgi.injectService(IBackgroundService,function(param1:Object):void {
        BattleView.backgroundService = IBackgroundService(param1);
      },function():IBackgroundService {
        return BattleView.backgroundService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        BattleView.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return BattleView.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleView.battleService = BattleService(param1);
      },function():BattleService {
        return BattleView.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattleView.display = IDisplay(param1);
      },function():IDisplay {
        return BattleView.display;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BattleView.storageService = IStorageService(param1);
      },function():IStorageService {
        return BattleView.storageService;
      });
      osgi.injectService(PerformanceDataService,function(param1:Object):void {
        PerformanceControllerWithThrottling.performanceDataService = PerformanceDataService(param1);
      },function():PerformanceDataService {
        return PerformanceControllerWithThrottling.performanceDataService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        SpeedHackChecker.clientLog = IClientLog(param1);
      },function():IClientLog {
        return SpeedHackChecker.clientLog;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        EndsPauseAlert.blurService = IBlurService(param1);
      },function():IBlurService {
        return EndsPauseAlert.blurService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        EndsPauseAlert.display = IDisplay(param1);
      },function():IDisplay {
        return EndsPauseAlert.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        EndsPauseAlert.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return EndsPauseAlert.localeService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        NotificationEndsPauseSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return NotificationEndsPauseSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        NotificationEndsPauseSupport.battleService = BattleService(param1);
      },function():BattleService {
        return NotificationEndsPauseSupport.battleService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        NotificationEndsPauseSupport.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return NotificationEndsPauseSupport.dialogWindowsDispatcherService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        NotificationEndsPauseSupport.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return NotificationEndsPauseSupport.lobbyLayoutService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        LocalChassisController.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return LocalChassisController.battleEventDispatcher;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        LocalChassisController.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return LocalChassisController.battleInputService;
      });
      osgi.injectService(CommandService,function(param1:Object):void {
        LocalChassisController.commandService = CommandService(param1);
      },function():CommandService {
        return LocalChassisController.commandService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LocalCheatController.battleService = BattleService(param1);
      },function():BattleService {
        return LocalCheatController.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        LocalCheatController.display = IDisplay(param1);
      },function():IDisplay {
        return LocalCheatController.display;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        LocalShaftController.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return LocalShaftController.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LocalShaftController.battleService = BattleService(param1);
      },function():BattleService {
        return LocalShaftController.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        LocalShaftController.display = IDisplay(param1);
      },function():IDisplay {
        return LocalShaftController.display;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        LocalShaftController.settings = ISettingsService(param1);
      },function():ISettingsService {
        return LocalShaftController.settings;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        LocalTurretController.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return LocalTurretController.battleInputService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        LocalTurretController.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return LocalTurretController.settingsService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShaftReticleDisplayController.battleService = BattleService(param1);
      },function():BattleService {
        return ShaftReticleDisplayController.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankSkin.battleService = BattleService(param1);
      },function():BattleService {
        return TankSkin.battleService;
      });
      osgi.injectService(ColorTransformService,function(param1:Object):void {
        TankSkin.colorTransformService = ColorTransformService(param1);
      },function():ColorTransformService {
        return TankSkin.colorTransformService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        TankSkin.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return TankSkin.textureMaterialRegistry;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        DebugBitmapLayer.display = IDisplay(param1);
      },function():IDisplay {
        return DebugBitmapLayer.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DefaultTankSkinMaterialsFactory.battleService = BattleService(param1);
      },function():BattleService {
        return DefaultTankSkinMaterialsFactory.battleService;
      });
      osgi.injectService(TankSkinTextureRegistry,function(param1:Object):void {
        DefaultTankSkinMaterialsFactory.skinTextureRegistry = TankSkinTextureRegistry(param1);
      },function():TankSkinTextureRegistry {
        return DefaultTankSkinMaterialsFactory.skinTextureRegistry;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        DefaultTankSkinMaterialsFactory.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return DefaultTankSkinMaterialsFactory.textureMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryTurretSkin.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryTurretSkin.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TurretSkin.battleService = BattleService(param1);
      },function():BattleService {
        return TurretSkin.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleScene3DDebugCommands.battleService = BattleService(param1);
      },function():BattleService {
        return BattleScene3DDebugCommands.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FadingDecalsRenderer.battleService = BattleService(param1);
      },function():BattleService {
        return FadingDecalsRenderer.battleService;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        BattleBonus.lightingService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return BattleBonus.lightingService;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        BonusMesh.lightingService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return BonusMesh.lightingService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BonusObject3DBase.battleService = BattleService(param1);
      },function():BattleService {
        return BonusObject3DBase.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BonusPickupAnimation.battleService = BattleService(param1);
      },function():BattleService {
        return BonusPickupAnimation.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GroundSpawnRenderer.battleService = BattleService(param1);
      },function():BattleService {
        return GroundSpawnRenderer.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ParachuteDetachAnimation.battleService = BattleService(param1);
      },function():BattleService {
        return ParachuteDetachAnimation.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RemovalAnimation.battleService = BattleService(param1);
      },function():BattleService {
        return RemovalAnimation.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpawnAnimation.battleService = BattleService(param1);
      },function():BattleService {
        return SpawnAnimation.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpawnFlashRenderer.battleService = BattleService(param1);
      },function():BattleService {
        return SpawnFlashRenderer.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CameraBookmark.battleService = BattleService(param1);
      },function():BattleService {
        return CameraBookmark.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        FollowCameraController.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return FollowCameraController.battleEventDispatcher;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        FollowCameraController.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return FollowCameraController.battleInputService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        FollowCameraController.display = IDisplay(param1);
      },function():IDisplay {
        return FollowCameraController.display;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        FollowCameraController.settings = ISettingsService(param1);
      },function():ISettingsService {
        return FollowCameraController.settings;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        FollowCameraController.storageService = IStorageService(param1);
      },function():IStorageService {
        return FollowCameraController.storageService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        PlayerCamera.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return PlayerCamera.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        PlayerCamera.battleService = BattleService(param1);
      },function():BattleService {
        return PlayerCamera.battleService;
      });
      osgi.injectService(IBonusRegionService,function(param1:Object):void {
        PlayerCamera.bonusRegionService = IBonusRegionService(param1);
      },function():IBonusRegionService {
        return PlayerCamera.bonusRegionService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        PlayerCamera.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return PlayerCamera.contextMenuService;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        PlayerCamera.tankUsersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return PlayerCamera.tankUsersRegistry;
      });
      osgi.injectService(IBonusRegionService,function(param1:Object):void {
        SpectatorBonusRegionController.bonusRegionService = IBonusRegionService(param1);
      },function():IBonusRegionService {
        return SpectatorBonusRegionController.bonusRegionService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpectatorCameraController.battleService = BattleService(param1);
      },function():BattleService {
        return SpectatorCameraController.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        SpectatorCameraController.display = IDisplay(param1);
      },function():IDisplay {
        return SpectatorCameraController.display;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        SpectatorSupport.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return SpectatorSupport.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpectatorSupport.battleService = BattleService(param1);
      },function():BattleService {
        return SpectatorSupport.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        SpectatorSupport.display = IDisplay(param1);
      },function():IDisplay {
        return SpectatorSupport.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TextureMaterialRegistryBase.battleService = BattleService(param1);
      },function():BattleService {
        return TextureMaterialRegistryBase.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        AssaultHudIndicators.battleService = BattleService(param1);
      },function():BattleService {
        return AssaultHudIndicators.battleService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AssaultMessages.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AssaultMessages.localeService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        AssaultMessages.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return AssaultMessages.userInfoService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        AssaultModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return AssaultModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        AssaultModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return AssaultModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        AssaultModel.battleService = BattleService(param1);
      },function():BattleService {
        return AssaultModel.battleService;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        AssaultModel.lightingEffectsService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return AssaultModel.lightingEffectsService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        AssaultModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return AssaultModel.localeService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        AssaultModel.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return AssaultModel.materialRegistry;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        AssaultModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return AssaultModel.userPropertiesService;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        PointBaseIndicatorPlane.lightingEffectsService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return PointBaseIndicatorPlane.lightingEffectsService;
      });
      osgi.injectService(TanksAddressService,function(param1:Object):void {
        BattlefieldModel.addressService = TanksAddressService(param1);
      },function():TanksAddressService {
        return BattlefieldModel.addressService;
      });
      osgi.injectService(IBackgroundService,function(param1:Object):void {
        BattlefieldModel.backgroundService = IBackgroundService(param1);
      },function():IBackgroundService {
        return BattlefieldModel.backgroundService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattlefieldModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattlefieldModel.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        BattlefieldModel.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return BattlefieldModel.battleGuiService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattlefieldModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattlefieldModel.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        BattlefieldModel.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return BattlefieldModel.battleInputService;
      });
      osgi.injectService(BattleReadinessService,function(param1:Object):void {
        BattlefieldModel.battleReadinessService = BattleReadinessService(param1);
      },function():BattleReadinessService {
        return BattlefieldModel.battleReadinessService;
      });
      osgi.injectService(ColorTransformService,function(param1:Object):void {
        BattlefieldModel.colorTransformService = ColorTransformService(param1);
      },function():ColorTransformService {
        return BattlefieldModel.colorTransformService;
      });
      osgi.injectService(DataValidator,function(param1:Object):void {
        BattlefieldModel.dataValidator = DataValidator(param1);
      },function():DataValidator {
        return BattlefieldModel.dataValidator;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattlefieldModel.display = IDisplay(param1);
      },function():IDisplay {
        return BattlefieldModel.display;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        BattlefieldModel.lightingAdjustService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return BattlefieldModel.lightingAdjustService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattlefieldModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattlefieldModel.lobbyLayoutService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattlefieldModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattlefieldModel.localeService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        BattlefieldModel.logService = LogService(param1);
      },function():LogService {
        return BattlefieldModel.logService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        BattlefieldModel.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return BattlefieldModel.materialRegistry;
      });
      osgi.injectService(MemoryLeakTrackerService,function(param1:Object):void {
        BattlefieldModel.memoryLeakTrackerService = MemoryLeakTrackerService(param1);
      },function():MemoryLeakTrackerService {
        return BattlefieldModel.memoryLeakTrackerService;
      });
      osgi.injectService(MipMappingService,function(param1:Object):void {
        BattlefieldModel.mipMappingService = MipMappingService(param1);
      },function():MipMappingService {
        return BattlefieldModel.mipMappingService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        BattlefieldModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return BattlefieldModel.notificationService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        BattlefieldModel.settings = ISettingsService(param1);
      },function():ISettingsService {
        return BattlefieldModel.settings;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        BattlefieldModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return BattlefieldModel.storageService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        FollowCameraControllerLocker.battleInputLockService = BattleInputService(param1);
      },function():BattleInputService {
        return FollowCameraControllerLocker.battleInputLockService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        FreeCameraSupport.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return FreeCameraSupport.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FreeCameraSupport.battleService = BattleService(param1);
      },function():BattleService {
        return FreeCameraSupport.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        FreeCameraSupport.display = IDisplay(param1);
      },function():IDisplay {
        return FreeCameraSupport.display;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        SpectatorFogToggleSupport.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return SpectatorFogToggleSupport.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpectatorFogToggleSupport.battleService = BattleService(param1);
      },function():BattleService {
        return SpectatorFogToggleSupport.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        SpectatorUserTitleRenderer.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return SpectatorUserTitleRenderer.battleEventDispatcher;
      });
      osgi.injectService(SpectatorService,function(param1:Object):void {
        SpectatorUserTitleRenderer.spectatorService = SpectatorService(param1);
      },function():SpectatorService {
        return SpectatorUserTitleRenderer.spectatorService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        StageFrameRateController.clientLog = IClientLog(param1);
      },function():IClientLog {
        return StageFrameRateController.clientLog;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        StageFrameRateController.display = IDisplay(param1);
      },function():IDisplay {
        return StageFrameRateController.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BillboardsDebugCommands.battleService = BattleService(param1);
      },function():BattleService {
        return BillboardsDebugCommands.battleService;
      });
      osgi.injectService(CommandService,function(param1:Object):void {
        BillboardsDebugCommands.commandService = CommandService(param1);
      },function():CommandService {
        return BillboardsDebugCommands.commandService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BillboardsModel.battleService = BattleService(param1);
      },function():BattleService {
        return BillboardsModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BillboardImageModel.battleService = BattleService(param1);
      },function():BattleService {
        return BillboardImageModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        AdditionUserTitleSwitcher.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return AdditionUserTitleSwitcher.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        AdditionUserTitleSwitcher.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return AdditionUserTitleSwitcher.battleGuiService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        AdditionUserTitleSwitcher.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return AdditionUserTitleSwitcher.battleInputService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        AdditionUserTitleSwitcher.display = IDisplay(param1);
      },function():IDisplay {
        return AdditionUserTitleSwitcher.display;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        AdditionUserTitleSwitcher.localTankService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return AdditionUserTitleSwitcher.localTankService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        Billboards.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return Billboards.textureMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MapBuilder.battleService = BattleService(param1);
      },function():BattleService {
        return MapBuilder.battleService;
      });
      osgi.injectService(CommandService,function(param1:Object):void {
        MapBuilder.commandService = CommandService(param1);
      },function():CommandService {
        return MapBuilder.commandService;
      });
      osgi.injectService(DataValidator,function(param1:Object):void {
        MapBuilder.dataValidator = DataValidator(param1);
      },function():DataValidator {
        return MapBuilder.dataValidator;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattleMinesModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattleMinesModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleMinesModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleMinesModel.battleService;
      });
      osgi.injectService(IDumpService,function(param1:Object):void {
        BattleMinesModel.dumperService = IDumpService(param1);
      },function():IDumpService {
        return BattleMinesModel.dumperService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        BattleMinesModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return BattleMinesModel.textureMaterialRegistry;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ProximityMine.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ProximityMine.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonFlag.battleService = BattleService(param1);
      },function():BattleService {
        return CommonFlag.battleService;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        CommonFlag.lightingEffectsService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return CommonFlag.lightingEffectsService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        Flag.battleService = BattleService(param1);
      },function():BattleService {
        return Flag.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        Flag.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return Flag.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MarkersUtils.battleService = BattleService(param1);
      },function():BattleService {
        return MarkersUtils.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        MarkersUtils.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return MarkersUtils.materialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        PointBasedBattleModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return PointBasedBattleModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        PointBasedBattleModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return PointBasedBattleModel.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        PointBasedBattleModel.battleInputLockService = BattleInputService(param1);
      },function():BattleInputService {
        return PointBasedBattleModel.battleInputLockService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        PointBasedBattleModel.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return PointBasedBattleModel.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        PointBasedBattleModel.battleService = BattleService(param1);
      },function():BattleService {
        return PointBasedBattleModel.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PointBasedBattleModel.display = IDisplay(param1);
      },function():IDisplay {
        return PointBasedBattleModel.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PointBasedBattleModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PointBasedBattleModel.localeService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        PointBasedBattleModel.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return PointBasedBattleModel.materialRegistry;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        PointBasedBattleModel.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return PointBasedBattleModel.userInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CTFHudIndicators.battleService = BattleService(param1);
      },function():BattleService {
        return CTFHudIndicators.battleService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CTFMessages.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CTFMessages.localeService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        CTFMessages.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return CTFMessages.userInfoService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        CTFModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return CTFModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CTFModel.battleService = BattleService(param1);
      },function():BattleService {
        return CTFModel.battleService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        CTFModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return CTFModel.localeService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        CTFModel.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return CTFModel.userInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FlagMessage.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FlagMessage.localeService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FlagPickupTimeoutTask.battleService = BattleService(param1);
      },function():BattleService {
        return FlagPickupTimeoutTask.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleDebugModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleDebugModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleDMModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleDMModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattleFacilitiesModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattleFacilitiesModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleFacilitiesModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleFacilitiesModel.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        BattleFacilitiesModel.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return BattleFacilitiesModel.localTankInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonFacilityModel.battleService = BattleService(param1);
      },function():BattleService {
        return CommonFacilityModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattleChat.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattleChat.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        BattleChat.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return BattleChat.battleGuiService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleChat.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleChat.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        BattleChat.battleInputLockService = BattleInputService(param1);
      },function():BattleInputService {
        return BattleChat.battleInputLockService;
      });
      osgi.injectService(IBlockUserService,function(param1:Object):void {
        BattleChat.blockUserService = IBlockUserService(param1);
      },function():IBlockUserService {
        return BattleChat.blockUserService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattleChat.display = IDisplay(param1);
      },function():IDisplay {
        return BattleChat.display;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        BattleChat.fullscreenService = FullscreenService(param1);
      },function():FullscreenService {
        return BattleChat.fullscreenService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleChat.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleChat.localeService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        BattleChat.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return BattleChat.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleChat.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleChat.userPropertiesService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleChatLine.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleChatLine.localeService;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        BattleChatModel.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return BattleChatModel.battleGuiService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleChatModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleChatModel.battleInfoService;
      });
      osgi.injectService(IContextMenuService,function(param1:Object):void {
        BattleChatModel.contextMenuService = IContextMenuService(param1);
      },function():IContextMenuService {
        return BattleChatModel.contextMenuService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattleChatModel.display = IDisplay(param1);
      },function():IDisplay {
        return BattleChatModel.display;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        ChatLocker.battleInputLockService = BattleInputService(param1);
      },function():BattleInputService {
        return ChatLocker.battleInputLockService;
      });
      osgi.injectService(IBlockUserService,function(param1:Object):void {
        BlockCommandHandler.blockUserService = IBlockUserService(param1);
      },function():IBlockUserService {
        return BlockCommandHandler.blockUserService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BlockCommandHandler.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BlockCommandHandler.localeService;
      });
      osgi.injectService(IBlockUserService,function(param1:Object):void {
        UnblockCommandHandler.blockUserService = IBlockUserService(param1);
      },function():IBlockUserService {
        return UnblockCommandHandler.blockUserService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        UnblockCommandHandler.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return UnblockCommandHandler.localeService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        DroneIndicatorModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return DroneIndicatorModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DroneIndicatorModel.battleService = BattleService(param1);
      },function():BattleService {
        return DroneIndicatorModel.battleService;
      });
      osgi.injectService(IInventoryPanel,function(param1:Object):void {
        DroneIndicatorModel.inventoryPanel = IInventoryPanel(param1);
      },function():IInventoryPanel {
        return DroneIndicatorModel.inventoryPanel;
      });
      osgi.injectService(UserSettingsChangedService,function(param1:Object):void {
        DroneIndicatorModel.settingsChangedService = UserSettingsChangedService(param1);
      },function():UserSettingsChangedService {
        return DroneIndicatorModel.settingsChangedService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        DroneIndicatorModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return DroneIndicatorModel.settingsService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        DroneIndicatorModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return DroneIndicatorModel.textureMaterialRegistry;
      });
      osgi.injectService(IGroupInfoService,function(param1:Object):void {
        MatchmakingGroupInfoModel.groupInfoService = IGroupInfoService(param1);
      },function():IGroupInfoService {
        return MatchmakingGroupInfoModel.groupInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ControlsHelper.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ControlsHelper.localeService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        ControlsMiniHelp.helpService = IHelpService(param1);
      },function():IHelpService {
        return ControlsMiniHelp.helpService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ControlsMiniHelp.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ControlsMiniHelp.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        FundField.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return FundField.localeService;
      });
      osgi.injectService(PerformanceDataService,function(param1:Object):void {
        FPSText.performanceDataService = PerformanceDataService(param1);
      },function():PerformanceDataService {
        return FPSText.performanceDataService;
      });
      osgi.injectService(PingService,function(param1:Object):void {
        FPSText.pingService = PingService(param1);
      },function():PingService {
        return FPSText.pingService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattleMessages.display = IDisplay(param1);
      },function():IDisplay {
        return BattleMessages.display;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        StatisticsListRenderer.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return StatisticsListRenderer.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        StatisticsTable.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return StatisticsTable.battleInputService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        StatisticsTable.display = IDisplay(param1);
      },function():IDisplay {
        return StatisticsTable.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        StatisticsTable.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return StatisticsTable.localeService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ViewStatistics.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ViewStatistics.localeService;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        ReloaderIndicator.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return ReloaderIndicator.battleGUIService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ReloaderIndicator.display = IDisplay(param1);
      },function():IDisplay {
        return ReloaderIndicator.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ReloaderIndicator.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ReloaderIndicator.localeService;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        SuicideIndicator.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return SuicideIndicator.battleGUIService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        SuicideIndicator.display = IDisplay(param1);
      },function():IDisplay {
        return SuicideIndicator.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        SuicideIndicator.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return SuicideIndicator.localeService;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        TurnOverIndicator.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return TurnOverIndicator.battleGUIService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        TurnOverIndicator.display = IDisplay(param1);
      },function():IDisplay {
        return TurnOverIndicator.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TurnOverIndicator.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TurnOverIndicator.localeService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        InventoryItemModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return InventoryItemModel.battleEventDispatcher;
      });
      osgi.injectService(IInventoryPanel,function(param1:Object):void {
        InventoryItemModel.inventoryPanel = IInventoryPanel(param1);
      },function():IInventoryPanel {
        return InventoryItemModel.inventoryPanel;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        InventoryModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return InventoryModel.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        InventoryModel.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return InventoryModel.battleGuiService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        InventoryModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return InventoryModel.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        InventoryModel.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return InventoryModel.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        InventoryModel.battleService = BattleService(param1);
      },function():BattleService {
        return InventoryModel.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        InventoryModel.display = IDisplay(param1);
      },function():IDisplay {
        return InventoryModel.display;
      });
      osgi.injectService(InventorySoundService,function(param1:Object):void {
        InventoryModel.inventorySoundService = InventorySoundService(param1);
      },function():InventorySoundService {
        return InventoryModel.inventorySoundService;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        InventoryModel.modelRegistry = ModelRegistry(param1);
      },function():ModelRegistry {
        return InventoryModel.modelRegistry;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        InventoryModel.tankUsersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return InventoryModel.tankUsersRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        InventoryPanelSlot.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return InventoryPanelSlot.battleEventDispatcher;
      });
      osgi.injectService(InventorySoundService,function(param1:Object):void {
        InventoryPanelSlot.inventorySoundService = InventorySoundService(param1);
      },function():InventorySoundService {
        return InventoryPanelSlot.inventorySoundService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        InventorySfxModel.battleService = BattleService(param1);
      },function():BattleService {
        return InventorySfxModel.battleService;
      });
      osgi.injectService(IInventoryPanel,function(param1:Object):void {
        InventoryCooldownModel.inventoryPanel = IInventoryPanel(param1);
      },function():IInventoryPanel {
        return InventoryCooldownModel.inventoryPanel;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        PointMarker.battleService = BattleService(param1);
      },function():BattleService {
        return PointMarker.battleService;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        DefaultLayout.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return DefaultLayout.battleGUIService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        DefaultLayout.display = IDisplay(param1);
      },function():IDisplay {
        return DefaultLayout.display;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        UltimateIndicator.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return UltimateIndicator.battleGuiService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        UltimateIndicator.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return UltimateIndicator.battleInputService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        UltimateIndicator.display = IDisplay(param1);
      },function():IDisplay {
        return UltimateIndicator.display;
      });
      osgi.injectService(IInventoryPanel,function(param1:Object):void {
        UltimateIndicator.inventoryPanel = IInventoryPanel(param1);
      },function():IInventoryPanel {
        return UltimateIndicator.inventoryPanel;
      });
      osgi.injectService(InventorySoundService,function(param1:Object):void {
        UltimateIndicator.inventorySoundService = InventorySoundService(param1);
      },function():InventorySoundService {
        return UltimateIndicator.inventorySoundService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleChatUserLabel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleChatUserLabel.battleInfoService;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        BattleChatUserLabel.tankUsersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return BattleChatUserLabel.tankUsersRegistry;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        BattleChatUserLabel.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return BattleChatUserLabel.userInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleJGRModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleJGRModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        JuggernautHudIndicator.battleService = BattleService(param1);
      },function():BattleService {
        return JuggernautHudIndicator.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        JuggernautModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return JuggernautModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        JuggernautModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return JuggernautModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        JuggernautModel.battleService = BattleService(param1);
      },function():BattleService {
        return JuggernautModel.battleService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        JuggernautModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return JuggernautModel.localeService;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        JuggernautModel.usersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return JuggernautModel.usersRegistry;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        KillStreakModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return KillStreakModel.battleInfoService;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        KillStreakModel.usersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return KillStreakModel.usersRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MeteorStormModel.battleService = BattleService(param1);
      },function():BattleService {
        return MeteorStormModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        MeteorStormModel.effectsMaterialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return MeteorStormModel.effectsMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        Ball.battleService = BattleService(param1);
      },function():BattleService {
        return Ball.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        Ball.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return Ball.materialRegistry;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        RugbyMessages.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return RugbyMessages.localeService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        RugbyModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return RugbyModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        RugbyModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return RugbyModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RugbyModel.battleService = BattleService(param1);
      },function():BattleService {
        return RugbyModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        RugbyModel.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return RugbyModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BallExplosionModel.battleService = BattleService(param1);
      },function():BattleService {
        return BallExplosionModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        BallExplosionModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return BallExplosionModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CameraStatisticFeature.battleService = BattleService(param1);
      },function():BattleService {
        return CameraStatisticFeature.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        FpsStatisticsModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return FpsStatisticsModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FpsStatisticsModel.battleService = BattleService(param1);
      },function():BattleService {
        return FpsStatisticsModel.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        FpsStatisticsModel.display = IDisplay(param1);
      },function():IDisplay {
        return FpsStatisticsModel.display;
      });
      osgi.injectService(LobbyLayoutService,function(param1:Object):void {
        FpsStatisticsModel.lobbyLayoutService = LobbyLayoutService(param1);
      },function():LobbyLayoutService {
        return FpsStatisticsModel.lobbyLayoutService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        FpsStatisticsModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return FpsStatisticsModel.settingsService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TargetingStatisticsModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TargetingStatisticsModel.battleEventDispatcher;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattleTDMModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattleTDMModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleTDMModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleTDMModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattlefieldBonusesModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattlefieldBonusesModel.battleEventDispatcher;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        BattlefieldBonusesModel.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return BattlefieldBonusesModel.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattlefieldBonusesModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattlefieldBonusesModel.userPropertiesService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BonusCommonModel.battleService = BattleService(param1);
      },function():BattleService {
        return BonusCommonModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        BonusCommonModel.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return BonusCommonModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleGoldBonusesModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleGoldBonusesModel.battleService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BattleGoldBonusesModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BattleGoldBonusesModel.localeService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        BattleGoldBonusesModel.userInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return BattleGoldBonusesModel.userInfoService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        BattleGoldBonusesModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return BattleGoldBonusesModel.userPropertiesService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GoldBonusesModel.battleService = BattleService(param1);
      },function():BattleService {
        return GoldBonusesModel.battleService;
      });
      osgi.injectService(IBonusRegionService,function(param1:Object):void {
        GoldBonusesModel.bonusRegionService = IBonusRegionService(param1);
      },function():IBonusRegionService {
        return GoldBonusesModel.bonusRegionService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BonusRegion.battleService = BattleService(param1);
      },function():BattleService {
        return BonusRegion.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BonusRegionsModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BonusRegionsModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BonusRegionsModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BonusRegionsModel.battleInfoService;
      });
      osgi.injectService(IBonusRegionService,function(param1:Object):void {
        BonusRegionsModel.bonusRegionService = IBonusRegionService(param1);
      },function():IBonusRegionService {
        return BonusRegionsModel.bonusRegionService;
      });
      osgi.injectService(MatchmakingFormService,function(param1:Object):void {
        MatchmakingContinueBattleModel.matchmakingFormService = MatchmakingFormService(param1);
      },function():MatchmakingFormService {
        return MatchmakingContinueBattleModel.matchmakingFormService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ControlPointsModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ControlPointsModel.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        ControlPointsModel.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return ControlPointsModel.battleGuiService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ControlPointsModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ControlPointsModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ControlPointsModel.battleService = BattleService(param1);
      },function():BattleService {
        return ControlPointsModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        ControlPointsModel.effectsMaterialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return ControlPointsModel.effectsMaterialRegistry;
      });
      osgi.injectService(ColorTransformService,function(param1:Object):void {
        KeyPointView.colorTransformService = ColorTransformService(param1);
      },function():ColorTransformService {
        return KeyPointView.colorTransformService;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        KeyPointView.lightingEffectsService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return KeyPointView.lightingEffectsService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        KeyPointView.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return KeyPointView.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        KeyPointHUDMarkers.battleService = BattleService(param1);
      },function():BattleService {
        return KeyPointHUDMarkers.battleService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        ControlPointMessage.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return ControlPointMessage.localeService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BeamEffects.battleService = BattleService(param1);
      },function():BattleService {
        return BeamEffects.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DroneEffects.battleService = BattleService(param1);
      },function():BattleService {
        return DroneEffects.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        DroneMaterialFactory.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return DroneMaterialFactory.textureMaterialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        EffectDescriptionModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return EffectDescriptionModel.battleEventDispatcher;
      });
      osgi.injectService(InventorySoundService,function(param1:Object):void {
        EffectDescriptionModel.inventorySoundService = InventorySoundService(param1);
      },function():InventorySoundService {
        return EffectDescriptionModel.inventorySoundService;
      });
      osgi.injectService(PerformanceDataService,function(param1:Object):void {
        PerformanceModel.performanceDataService = PerformanceDataService(param1);
      },function():PerformanceDataService {
        return PerformanceModel.performanceDataService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankEffectSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankEffectSFXModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        TankEffectSFXModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return TankEffectSFXModel.textureMaterialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        HullSmokeModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return HullSmokeModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        HullSmokeModel.battleService = BattleService(param1);
      },function():BattleService {
        return HullSmokeModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        HullSmokeRenderer.battleService = BattleService(param1);
      },function():BattleService {
        return HullSmokeRenderer.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        HullSmokeRenderer.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return HullSmokeRenderer.materialRegistry;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattlefieldMessagesAligner.display = IDisplay(param1);
      },function():IDisplay {
        return BattlefieldMessagesAligner.display;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        ControlsHelpSupport.helpService = IHelpService(param1);
      },function():IHelpService {
        return ControlsHelpSupport.helpService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ControlsHelpSupport.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ControlsHelpSupport.lobbyLayoutService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ControlsMiniHelpSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ControlsMiniHelpSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        ControlsMiniHelpSupport.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return ControlsMiniHelpSupport.battleGuiService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ControlsMiniHelpSupport.display = IDisplay(param1);
      },function():IDisplay {
        return ControlsMiniHelpSupport.display;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        ControlsMiniHelpSupport.storageService = IStorageService(param1);
      },function():IStorageService {
        return ControlsMiniHelpSupport.storageService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        ControlsMiniHelpSupport.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return ControlsMiniHelpSupport.userPropertiesService;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        FpsIndicatorToggleSupport.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return FpsIndicatorToggleSupport.battleGuiService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        FpsIndicatorToggleSupport.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return FpsIndicatorToggleSupport.settingsService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        PauseIndicatorSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return PauseIndicatorSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        PauseIndicatorSupport.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return PauseIndicatorSupport.battleGUIService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        PauseIndicatorSupport.battleService = BattleService(param1);
      },function():BattleService {
        return PauseIndicatorSupport.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PauseIndicatorSupport.display = IDisplay(param1);
      },function():IDisplay {
        return PauseIndicatorSupport.display;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        PauseIndicatorSupport.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return PauseIndicatorSupport.localeService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        SpectatorScreenLayouts.battleInput = BattleInputService(param1);
      },function():BattleInputService {
        return SpectatorScreenLayouts.battleInput;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        SpectatorScreenLayouts.display = IDisplay(param1);
      },function():IDisplay {
        return SpectatorScreenLayouts.display;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        SpectatorScreenLayouts.guiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return SpectatorScreenLayouts.guiService;
      });
      osgi.injectService(IPanelView,function(param1:Object):void {
        SpectatorScreenLayouts.panelView = IPanelView(param1);
      },function():IPanelView {
        return SpectatorScreenLayouts.panelView;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        SpectatorScreenLayouts.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return SpectatorScreenLayouts.settingsService;
      });
      osgi.injectService(SpectatorService,function(param1:Object):void {
        SpectatorScreenLayouts.spectatorService = SpectatorService(param1);
      },function():SpectatorService {
        return SpectatorScreenLayouts.spectatorService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        StatisticsModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return StatisticsModel.battleEventDispatcher;
      });
      osgi.injectService(BattleFormatUtil,function(param1:Object):void {
        StatisticsModel.battleFormatUtil = BattleFormatUtil(param1);
      },function():BattleFormatUtil {
        return StatisticsModel.battleFormatUtil;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        StatisticsModel.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return StatisticsModel.battleGUIService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        StatisticsModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return StatisticsModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        StatisticsModel.battleService = BattleService(param1);
      },function():BattleService {
        return StatisticsModel.battleService;
      });
      osgi.injectService(IHelpService,function(param1:Object):void {
        StatisticsModel.helpService = IHelpService(param1);
      },function():IHelpService {
        return StatisticsModel.helpService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        StatisticsModel.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return StatisticsModel.localTankInfoService;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        StatisticsModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return StatisticsModel.localeService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        StatisticsModel.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return StatisticsModel.settingsService;
      });
      osgi.injectService(IStorageService,function(param1:Object):void {
        StatisticsModel.storageService = IStorageService(param1);
      },function():IStorageService {
        return StatisticsModel.storageService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        StatisticsModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return StatisticsModel.userPropertiesService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TankKillLogger.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TankKillLogger.battleEventDispatcher;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        TankKillLogger.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return TankKillLogger.localeService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        StatisticsDmModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return StatisticsDmModel.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        StatisticsDmModel.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return StatisticsDmModel.battleGUIService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        StatisticsDmModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return StatisticsDmModel.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        StatisticsDmModel.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return StatisticsDmModel.battleInputService;
      });
      osgi.injectService(BattleUserPremiumService,function(param1:Object):void {
        StatisticsDmModel.battlePremiumService = BattleUserPremiumService(param1);
      },function():BattleUserPremiumService {
        return StatisticsDmModel.battlePremiumService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        StatisticsDmModel.display = IDisplay(param1);
      },function():IDisplay {
        return StatisticsDmModel.display;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        StatisticsDmModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return StatisticsDmModel.lobbyLayoutService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        StatisticsDmModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return StatisticsDmModel.notificationService;
      });
      osgi.injectService(ReconnectService,function(param1:Object):void {
        StatisticsDmModel.reconnectService = ReconnectService(param1);
      },function():ReconnectService {
        return StatisticsDmModel.reconnectService;
      });
      osgi.injectService(IServerHaltService,function(param1:Object):void {
        StatisticsDmModel.serverHaltService = IServerHaltService(param1);
      },function():IServerHaltService {
        return StatisticsDmModel.serverHaltService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        StatisticsDmModel.starsEventService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return StatisticsDmModel.starsEventService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        StatisticsDmModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return StatisticsDmModel.userPropertiesService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        StatisticsTeamModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return StatisticsTeamModel.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        StatisticsTeamModel.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return StatisticsTeamModel.battleGUIService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        StatisticsTeamModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return StatisticsTeamModel.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        StatisticsTeamModel.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return StatisticsTeamModel.battleInputService;
      });
      osgi.injectService(BattleUserPremiumService,function(param1:Object):void {
        StatisticsTeamModel.battlePremiumService = BattleUserPremiumService(param1);
      },function():BattleUserPremiumService {
        return StatisticsTeamModel.battlePremiumService;
      });
      osgi.injectService(ChallengeInfoService,function(param1:Object):void {
        StatisticsTeamModel.challengeInfoService = ChallengeInfoService(param1);
      },function():ChallengeInfoService {
        return StatisticsTeamModel.challengeInfoService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        StatisticsTeamModel.display = IDisplay(param1);
      },function():IDisplay {
        return StatisticsTeamModel.display;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        StatisticsTeamModel.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return StatisticsTeamModel.lobbyLayoutService;
      });
      osgi.injectService(INotificationService,function(param1:Object):void {
        StatisticsTeamModel.notificationService = INotificationService(param1);
      },function():INotificationService {
        return StatisticsTeamModel.notificationService;
      });
      osgi.injectService(IServerHaltService,function(param1:Object):void {
        StatisticsTeamModel.serverHaltService = IServerHaltService(param1);
      },function():IServerHaltService {
        return StatisticsTeamModel.serverHaltService;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        StatisticsTeamModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return StatisticsTeamModel.userPropertiesService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ChassisStateCorrectionTask.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ChassisStateCorrectionTask.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LocalWeaponController.battleService = BattleService(param1);
      },function():BattleService {
        return LocalWeaponController.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        MainLoopExecutionErrorHandler.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return MainLoopExecutionErrorHandler.battleEventDispatcher;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PositionBookmarks.display = IDisplay(param1);
      },function():IDisplay {
        return PositionBookmarks.display;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        RegularUserTitleRenderer.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return RegularUserTitleRenderer.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RegularUserTitleRenderer.battleService = BattleService(param1);
      },function():BattleService {
        return RegularUserTitleRenderer.battleService;
      });
      osgi.injectService(BattleReadinessService,function(param1:Object):void {
        SpawnCameraConfigurator.battleReadinessService = BattleReadinessService(param1);
      },function():BattleReadinessService {
        return SpawnCameraConfigurator.battleReadinessService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpawnCameraConfigurator.battleService = BattleService(param1);
      },function():BattleService {
        return SpawnCameraConfigurator.battleService;
      });
      osgi.injectService(DataValidator,function(param1:Object):void {
        TankDataValidatorWrapper.dataValidator = DataValidator(param1);
      },function():DataValidator {
        return TankDataValidatorWrapper.dataValidator;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TankModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TankModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        TankModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return TankModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankModel.battleService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        TankModel.battleUserInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return TankModel.battleUserInfoService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        TankModel.display = IDisplay(param1);
      },function():IDisplay {
        return TankModel.display;
      });
      osgi.injectService(IInitialEffectsService,function(param1:Object):void {
        TankModel.initialEffectsService = IInitialEffectsService(param1);
      },function():IInitialEffectsService {
        return TankModel.initialEffectsService;
      });
      osgi.injectService(IInventoryPanel,function(param1:Object):void {
        TankModel.inventoryPanel = IInventoryPanel(param1);
      },function():IInventoryPanel {
        return TankModel.inventoryPanel;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        TankModel.logService = LogService(param1);
      },function():LogService {
        return TankModel.logService;
      });
      osgi.injectService(MemoryLeakTrackerService,function(param1:Object):void {
        TankModel.memoryLeakTrackerService = MemoryLeakTrackerService(param1);
      },function():MemoryLeakTrackerService {
        return TankModel.memoryLeakTrackerService;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        TankModel.modelRegistry = ModelRegistry(param1);
      },function():ModelRegistry {
        return TankModel.modelRegistry;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        TankModel.settings = ISettingsService(param1);
      },function():ISettingsService {
        return TankModel.settings;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        TankModel.tankUsersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return TankModel.tankUsersRegistry;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        TankModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return TankModel.textureMaterialRegistry;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        TankUserInfoUpdater.usersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return TankUserInfoUpdater.usersRegistry;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BossStateModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BossStateModel.battleInfoService;
      });
      osgi.injectService(IInventoryPanel,function(param1:Object):void {
        BossStateModel.inventoryPanel = IInventoryPanel(param1);
      },function():IInventoryPanel {
        return BossStateModel.inventoryPanel;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        BossStateModel.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return BossStateModel.localeService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankExplosionModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankExplosionModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        TankExplosionModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return TankExplosionModel.materialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        CommonTankDieHandler.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return CommonTankDieHandler.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonTankDieHandler.battleService = BattleService(param1);
      },function():BattleService {
        return CommonTankDieHandler.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        DeathConfirmationTimeoutTask.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return DeathConfirmationTimeoutTask.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DeathConfirmationTimeoutTask.battleService = BattleService(param1);
      },function():BattleService {
        return DeathConfirmationTimeoutTask.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankPauseModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankPauseModel.battleService;
      });
      osgi.injectService(BattleUserInfoService,function(param1:Object):void {
        RankChangeListener.battleUserInfoService = BattleUserInfoService(param1);
      },function():BattleUserInfoService {
        return RankChangeListener.battleUserInfoService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ScheduledTankRankChangeEffect.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ScheduledTankRankChangeEffect.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankRankUpEffectModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankRankUpEffectModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TankReloaderModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TankReloaderModel.battleEventDispatcher;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        TankResistancesModel.usersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return TankResistancesModel.usersRegistry;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        ReadyToPlaceTask.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return ReadyToPlaceTask.lobbyLayoutService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ReadyToSpawnTask.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ReadyToSpawnTask.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ReadyToSpawnTask.battleService = BattleService(param1);
      },function():BattleService {
        return ReadyToSpawnTask.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TankSpawnerModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TankSpawnerModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankSpawnerModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankSpawnerModel.battleService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        TankSpawnerModel.logService = LogService(param1);
      },function():LogService {
        return TankSpawnerModel.logService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        LocalTankFirstTimeSpawner.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return LocalTankFirstTimeSpawner.battleEventDispatcher;
      });
      osgi.injectService(BattleReadinessService,function(param1:Object):void {
        LocalTankFirstTimeSpawner.battleReadinessService = BattleReadinessService(param1);
      },function():BattleReadinessService {
        return LocalTankFirstTimeSpawner.battleReadinessService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        LocalReadyToSpawnHandler.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return LocalReadyToSpawnHandler.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LocalSpawnHandler.battleService = BattleService(param1);
      },function():BattleService {
        return LocalSpawnHandler.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SpectatorSpawnHandler.battleService = BattleService(param1);
      },function():BattleService {
        return SpectatorSpawnHandler.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        SuicideModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return SuicideModel.battleEventDispatcher;
      });
      osgi.injectService(AutomaticEnterExitService,function(param1:Object):void {
        AutoExitSupport.autoEnterExitService = AutomaticEnterExitService(param1);
      },function():AutomaticEnterExitService {
        return AutoExitSupport.autoEnterExitService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        AutoExitSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return AutoExitSupport.battleEventDispatcher;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ClientDeactivationSupport.display = IDisplay(param1);
      },function():IDisplay {
        return ClientDeactivationSupport.display;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        DialogWindowSupport.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return DialogWindowSupport.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DialogWindowSupport.battleService = BattleService(param1);
      },function():BattleService {
        return DialogWindowSupport.battleService;
      });
      osgi.injectService(IBlurService,function(param1:Object):void {
        DialogWindowSupport.blurService = IBlurService(param1);
      },function():IBlurService {
        return DialogWindowSupport.blurService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        DialogWindowSupport.dialogService = IDialogsService(param1);
      },function():IDialogsService {
        return DialogWindowSupport.dialogService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        DialogWindowSupport.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return DialogWindowSupport.dialogWindowsDispatcherService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        DialogWindowSupport.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return DialogWindowSupport.lobbyLayoutService;
      });
      osgi.injectService(PaymentDisplayService,function(param1:Object):void {
        DialogWindowSupport.paymentDisplayService = PaymentDisplayService(param1);
      },function():PaymentDisplayService {
        return DialogWindowSupport.paymentDisplayService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        PauseSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return PauseSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        PauseSupport.battleGUIService = BattleGUIService(param1);
      },function():BattleGUIService {
        return PauseSupport.battleGUIService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        PauseSupport.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return PauseSupport.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        PauseSupport.battleService = BattleService(param1);
      },function():BattleService {
        return PauseSupport.battleService;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        PauseSupport.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return PauseSupport.dialogWindowsDispatcherService;
      });
      osgi.injectService(IDialogsService,function(param1:Object):void {
        PauseSupport.dialogsService = IDialogsService(param1);
      },function():IDialogsService {
        return PauseSupport.dialogsService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        PauseSupport.display = IDisplay(param1);
      },function():IDisplay {
        return PauseSupport.display;
      });
      osgi.injectService(FullscreenStateService,function(param1:Object):void {
        PauseSupport.fullscreenStateService = FullscreenStateService(param1);
      },function():FullscreenStateService {
        return PauseSupport.fullscreenStateService;
      });
      osgi.injectService(KeysBindingService,function(param1:Object):void {
        PauseSupport.keysBindingService = KeysBindingService(param1);
      },function():KeysBindingService {
        return PauseSupport.keysBindingService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        PauseSupport.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return PauseSupport.lobbyLayoutService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        StateCorrectionSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return StateCorrectionSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        SuicideSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return SuicideSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        SuicideSupport.battleInputLockService = BattleInputService(param1);
      },function():BattleInputService {
        return SuicideSupport.battleInputLockService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SuicideSupport.battleService = BattleService(param1);
      },function():BattleService {
        return SuicideSupport.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        SuicideSupport.display = IDisplay(param1);
      },function():IDisplay {
        return SuicideSupport.display;
      });
      osgi.injectService(KeysBindingService,function(param1:Object):void {
        SuicideSupport.keysBindingService = KeysBindingService(param1);
      },function():KeysBindingService {
        return SuicideSupport.keysBindingService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TankReloaderSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TankReloaderSupport.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankReloaderSupport.battleService = BattleService(param1);
      },function():BattleService {
        return TankReloaderSupport.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        TankReloaderSupport.display = IDisplay(param1);
      },function():IDisplay {
        return TankReloaderSupport.display;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        TankSettingsSupport.settings = ISettingsService(param1);
      },function():ISettingsService {
        return TankSettingsSupport.settings;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TurnOverIndicatorSupport.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TurnOverIndicatorSupport.battleEventDispatcher;
      });
      osgi.injectService(IDialogWindowsDispatcherService,function(param1:Object):void {
        TurnOverIndicatorSupport.dialogWindowsDispatcherService = IDialogWindowsDispatcherService(param1);
      },function():IDialogWindowsDispatcherService {
        return TurnOverIndicatorSupport.dialogWindowsDispatcherService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        TurnOverIndicatorSupport.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return TurnOverIndicatorSupport.lobbyLayoutService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TankTurnOverModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TankTurnOverModel.battleEventDispatcher;
      });
      osgi.injectService(IUserPropertiesService,function(param1:Object):void {
        TankTurnOverModel.userPropertiesService = IUserPropertiesService(param1);
      },function():IUserPropertiesService {
        return TankTurnOverModel.userPropertiesService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        UltimateModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return UltimateModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        UltimateModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return UltimateModel.battleInfoService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        UltimateModel.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return UltimateModel.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        UltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return UltimateModel.battleService;
      });
      osgi.injectService(InventorySoundService,function(param1:Object):void {
        UltimateModel.inventorySoundService = InventorySoundService(param1);
      },function():InventorySoundService {
        return UltimateModel.inventorySoundService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        UltimateModel.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return UltimateModel.localTankInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DictatorUltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return DictatorUltimateModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        DictatorUltimateModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return DictatorUltimateModel.textureMaterialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        HornetUltimateModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return HornetUltimateModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        HornetUltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return HornetUltimateModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        HornetUltimateModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return HornetUltimateModel.textureMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleRadarHudIndicators.battleService = BattleService(param1);
      },function():BattleService {
        return BattleRadarHudIndicators.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        BattleRadarHudIndicators.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return BattleRadarHudIndicators.localTankInfoService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        BattleUltimateRadarModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return BattleUltimateRadarModel.battleEventDispatcher;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        BattleUltimateRadarModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return BattleUltimateRadarModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleUltimateRadarModel.battleService = BattleService(param1);
      },function():BattleService {
        return BattleUltimateRadarModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        HunterUltimateModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return HunterUltimateModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        HunterUltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return HunterUltimateModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        HunterUltimateModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return HunterUltimateModel.textureMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TankStunModel.battleService = BattleService(param1);
      },function():BattleService {
        return TankStunModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        TankStunModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return TankStunModel.textureMaterialRegistry;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        JuggernautUltimateModel.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return JuggernautUltimateModel.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        JuggernautUltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return JuggernautUltimateModel.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        MammothUltimateModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return MammothUltimateModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MammothUltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return MammothUltimateModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        MammothUltimateModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return MammothUltimateModel.textureMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TitanUltimateGeneratorModel.battleService = BattleService(param1);
      },function():BattleService {
        return TitanUltimateGeneratorModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        TitanUltimateGeneratorModel.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return TitanUltimateGeneratorModel.materialRegistry;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        TitanUltimateGeneratorModel.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return TitanUltimateGeneratorModel.userInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        VikingUltimateModel.battleService = BattleService(param1);
      },function():BattleService {
        return VikingUltimateModel.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        VikingUltimateModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return VikingUltimateModel.textureMaterialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        WaspUltimateBombModel.battleService = BattleService(param1);
      },function():BattleService {
        return WaspUltimateBombModel.battleService;
      });
      osgi.injectService(InventorySoundService,function(param1:Object):void {
        WaspUltimateBombModel.inventorySoundService = InventorySoundService(param1);
      },function():InventorySoundService {
        return WaspUltimateBombModel.inventorySoundService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        WaspUltimateBombModel.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return WaspUltimateBombModel.localTankInfoService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        WaspUltimateBombModel.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return WaspUltimateBombModel.textureMaterialRegistry;
      });
      osgi.injectService(ILightingEffectsService,function(param1:Object):void {
        TeamLightModel.lightingEffectsService = ILightingEffectsService(param1);
      },function():ILightingEffectsService {
        return TeamLightModel.lightingEffectsService;
      });
      osgi.injectService(PingService,function(param1:Object):void {
        TimeCheckerModel.pingService = PingService(param1);
      },function():PingService {
        return TimeCheckerModel.pingService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryCannonEffect.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryCannonEffect.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        ArtilleryShell.textureMaterialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return ArtilleryShell.textureMaterialRegistry;
      });
      osgi.injectService(BattleGUIService,function(param1:Object):void {
        VerticalAngleView.battleGuiService = BattleGUIService(param1);
      },function():BattleGUIService {
        return VerticalAngleView.battleGuiService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        VerticalAngleView.battleService = BattleService(param1);
      },function():BattleService {
        return VerticalAngleView.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        VerticalAngleView.display = IDisplay(param1);
      },function():IDisplay {
        return VerticalAngleView.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryElevatingBarrelModel.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryElevatingBarrelModel.battleService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        BarrelElevationController.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return BarrelElevationController.battleInputService;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        BarrelElevationController.fullScreenService = FullscreenService(param1);
      },function():FullscreenService {
        return BarrelElevationController.fullScreenService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        BarrelElevationController.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return BarrelElevationController.settingsService;
      });
      osgi.injectService(IBattleInfoService,function(param1:Object):void {
        ArtilleryEffects.battleInfoService = IBattleInfoService(param1);
      },function():IBattleInfoService {
        return ArtilleryEffects.battleInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryEffects.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryEffects.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        ArtilleryEffects.localTankService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return ArtilleryEffects.localTankService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryFlame.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryFlame.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        ArtillerySfxData.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return ArtillerySfxData.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryShellEffects.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryShellEffects.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        ArtilleryShellEffects.localTankService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return ArtilleryShellEffects.localTankService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryShotEffect.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryShotEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ArtilleryTrailEffect.battleService = BattleService(param1);
      },function():BattleService {
        return ArtilleryTrailEffect.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        WeaponCommonModel.display = IDisplay(param1);
      },function():IDisplay {
        return WeaponCommonModel.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FlamethrowerEffects.battleService = BattleService(param1);
      },function():BattleService {
        return FlamethrowerEffects.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        FlamethrowerModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return FlamethrowerModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FlamethrowerModel.battleService = BattleService(param1);
      },function():BattleService {
        return FlamethrowerModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FlamethrowerSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return FlamethrowerSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        FlamethrowerSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return FlamethrowerSFXModel.materialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        FreezeModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return FreezeModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FreezeModel.battleService = BattleService(param1);
      },function():BattleService {
        return FreezeModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FreezeSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return FreezeSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        FreezeSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return FreezeSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonGaussWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return CommonGaussWeapon.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        GaussModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return GaussModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GaussModel.battleService = BattleService(param1);
      },function():BattleService {
        return GaussModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GaussAntennaAimingEffect.battleService = BattleService(param1);
      },function():BattleService {
        return GaussAntennaAimingEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GaussEffects.battleService = BattleService(param1);
      },function():BattleService {
        return GaussEffects.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GaussMuzzleEffect.battleService = BattleService(param1);
      },function():BattleService {
        return GaussMuzzleEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GaussPowerShotEffect.battleService = BattleService(param1);
      },function():BattleService {
        return GaussPowerShotEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        GaussSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return GaussSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        GaussSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return GaussSFXModel.materialRegistry;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        HealingGunModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return HealingGunModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        HealingGunModel.battleService = BattleService(param1);
      },function():BattleService {
        return HealingGunModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        HealingGunSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return HealingGunSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        HealingGunSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return HealingGunSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        IsisTargetPriorityCalculator.battleService = BattleService(param1);
      },function():BattleService {
        return IsisTargetPriorityCalculator.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LaserPointerEffect.battleService = BattleService(param1);
      },function():BattleService {
        return LaserPointerEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LaserPointerModel.battleService = BattleService(param1);
      },function():BattleService {
        return LaserPointerModel.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        LaserPointerModel.localTankInfoService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return LaserPointerModel.localTankInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunCommonWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunCommonWeapon.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunModel.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunRemoteWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunRemoteWeapon.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunWeapon.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunEffects.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunEffects.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        MachineGunSFXData.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return MachineGunSFXData.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunShotEffect.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunShotEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ParticleSystem.battleService = BattleService(param1);
      },function():BattleService {
        return ParticleSystem.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MachineGunSoundManager.battleService = BattleService(param1);
      },function():BattleService {
        return MachineGunSoundManager.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        RailgunModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return RailgunModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RailgunModel.battleService = BattleService(param1);
      },function():BattleService {
        return RailgunModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RailgunSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return RailgunSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        RailgunSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return RailgunSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RicochetAmmunition.battleService = BattleService(param1);
      },function():BattleService {
        return RicochetAmmunition.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        RicochetModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return RicochetModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RicochetModel.battleService = BattleService(param1);
      },function():BattleService {
        return RicochetModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RicochetSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return RicochetSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        RicochetSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return RicochetSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RicochetWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return RicochetWeapon.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RocketFlightEffect.battleService = BattleService(param1);
      },function():BattleService {
        return RocketFlightEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RocketLauncherEffects.battleService = BattleService(param1);
      },function():BattleService {
        return RocketLauncherEffects.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        RocketLauncherSfxData.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return RocketLauncherSfxData.materialRegistry;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        RocketSmoke.settings = ISettingsService(param1);
      },function():ISettingsService {
        return RocketSmoke.settings;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RemoteRocketLauncherWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return RemoteRocketLauncherWeapon.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RocketLauncherWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return RocketLauncherWeapon.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RocketLauncherAim.battleService = BattleService(param1);
      },function():BattleService {
        return RocketLauncherAim.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ReticleDisplay.battleService = BattleService(param1);
      },function():BattleService {
        return ReticleDisplay.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ShaftModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ShaftModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShaftModel.battleService = BattleService(param1);
      },function():BattleService {
        return ShaftModel.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ShaftModel.display = IDisplay(param1);
      },function():IDisplay {
        return ShaftModel.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShaftSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return ShaftSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        ShaftSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return ShaftSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShaftWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return ShaftWeapon.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ShaftWeapon.display = IDisplay(param1);
      },function():IDisplay {
        return ShaftWeapon.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        AimingCameraController.battleService = BattleService(param1);
      },function():BattleService {
        return AimingCameraController.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        AimingCameraController.display = IDisplay(param1);
      },function():IDisplay {
        return AimingCameraController.display;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        MarginalCollider.battleService = BattleService(param1);
      },function():BattleService {
        return MarginalCollider.battleService;
      });
      osgi.injectService(BattleInputService,function(param1:Object):void {
        SimpleWeaponController.battleInputService = BattleInputService(param1);
      },function():BattleInputService {
        return SimpleWeaponController.battleInputService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShotgunModel.battleService = BattleService(param1);
      },function():BattleService {
        return ShotgunModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShotgunRicochetTargetingSystem.battleService = BattleService(param1);
      },function():BattleService {
        return ShotgunRicochetTargetingSystem.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShotgunEffects.battleService = BattleService(param1);
      },function():BattleService {
        return ShotgunEffects.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        ShotgunSFXData.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return ShotgunSFXData.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShotgunSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return ShotgunSFXModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShotgunShotEffect.battleService = BattleService(param1);
      },function():BattleService {
        return ShotgunShotEffect.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        SmokyModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return SmokyModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SmokyModel.battleService = BattleService(param1);
      },function():BattleService {
        return SmokyModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SmokyEffects.battleService = BattleService(param1);
      },function():BattleService {
        return SmokyEffects.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SmokySFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return SmokySFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        SmokySFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return SmokySFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SplashModel.battleService = BattleService(param1);
      },function():BattleService {
        return SplashModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RemoteTerminatorWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return RemoteTerminatorWeapon.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TerminatorModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TerminatorModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TerminatorModel.battleService = BattleService(param1);
      },function():BattleService {
        return TerminatorModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TerminatorEffects.battleService = BattleService(param1);
      },function():BattleService {
        return TerminatorEffects.battleService;
      });
      osgi.injectService(LocalTankInfoService,function(param1:Object):void {
        TerminatorEffects.localTankService = LocalTankInfoService(param1);
      },function():LocalTankInfoService {
        return TerminatorEffects.localTankService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TerminatorOpenEffect.battleService = BattleService(param1);
      },function():BattleService {
        return TerminatorOpenEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TerminatorRecoilEffect.battleService = BattleService(param1);
      },function():BattleService {
        return TerminatorRecoilEffect.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ThunderModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ThunderModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ThunderModel.battleService = BattleService(param1);
      },function():BattleService {
        return ThunderModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ThunderSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return ThunderSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        ThunderSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return ThunderSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        RotatingTurretModel.battleService = BattleService(param1);
      },function():BattleService {
        return RotatingTurretModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TwinsAmmunition.battleService = BattleService(param1);
      },function():BattleService {
        return TwinsAmmunition.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        TwinsModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return TwinsModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TwinsModel.battleService = BattleService(param1);
      },function():BattleService {
        return TwinsModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TwinsSFXModel.battleService = BattleService(param1);
      },function():BattleService {
        return TwinsSFXModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        TwinsSFXModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return TwinsSFXModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonLocalWeapon.battleService = BattleService(param1);
      },function():BattleService {
        return CommonLocalWeapon.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        DiscreteWeaponCommunicationModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return DiscreteWeaponCommunicationModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        Shell.battleService = BattleService(param1);
      },function():BattleService {
        return Shell.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        ShellWeaponCommunicationModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return ShellWeaponCommunicationModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShellWeaponCommunicationModel.battleService = BattleService(param1);
      },function():BattleService {
        return ShellWeaponCommunicationModel.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShellStates.battleService = BattleService(param1);
      },function():BattleService {
        return ShellStates.battleService;
      });
      osgi.injectService(BattleEventDispatcher,function(param1:Object):void {
        StreamWeaponCommunicationModel.battleEventDispatcher = BattleEventDispatcher(param1);
      },function():BattleEventDispatcher {
        return StreamWeaponCommunicationModel.battleEventDispatcher;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        TargetingVisualDebug.battleService = BattleService(param1);
      },function():BattleService {
        return TargetingVisualDebug.battleService;
      });
      osgi.injectService(TankUsersRegistry,function(param1:Object):void {
        TargetingSectorsCalculator.tankUsersRegistry = TankUsersRegistry(param1);
      },function():TankUsersRegistry {
        return TargetingSectorsCalculator.tankUsersRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonTargetPriorityCalculator.battleService = BattleService(param1);
      },function():BattleService {
        return CommonTargetPriorityCalculator.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        PenetratingTargetPriorityCalculator.battleService = BattleService(param1);
      },function():BattleService {
        return PenetratingTargetPriorityCalculator.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        ShaftTargetPriorityCalculator.battleService = BattleService(param1);
      },function():BattleService {
        return ShaftTargetPriorityCalculator.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        CommonDirectionProcessor.battleService = BattleService(param1);
      },function():BattleService {
        return CommonDirectionProcessor.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DirectionProcessorForPenetratingWeapons.battleService = BattleService(param1);
      },function():BattleService {
        return DirectionProcessorForPenetratingWeapons.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SingleTargetDirectionProcessor.battleService = BattleService(param1);
      },function():BattleService {
        return SingleTargetDirectionProcessor.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SingleTargetPrecisionDirectionProcessor.battleService = BattleService(param1);
      },function():BattleService {
        return SingleTargetPrecisionDirectionProcessor.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        SoaringChecker.battleService = BattleService(param1);
      },function():BattleService {
        return SoaringChecker.battleService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        BattleGUIServiceImpl.display = IDisplay(param1);
      },function():IDisplay {
        return BattleGUIServiceImpl.display;
      });
      osgi.injectService(FullscreenService,function(param1:Object):void {
        BattleInputServiceImpl.fullScreenService = FullscreenService(param1);
      },function():FullscreenService {
        return BattleInputServiceImpl.fullScreenService;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        BattleInputServiceImpl.settingsService = ISettingsService(param1);
      },function():ISettingsService {
        return BattleInputServiceImpl.settingsService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BattleReadinessServiceImpl.battleSerivce = BattleService(param1);
      },function():BattleService {
        return BattleReadinessServiceImpl.battleSerivce;
      });
      osgi.injectService(ILoaderWindowService,function(param1:Object):void {
        BattleReadinessServiceImpl.loaderWindowService = ILoaderWindowService(param1);
      },function():ILoaderWindowService {
        return BattleReadinessServiceImpl.loaderWindowService;
      });
      osgi.injectService(ILobbyLayoutService,function(param1:Object):void {
        BattleReadinessServiceImpl.lobbyLayoutService = ILobbyLayoutService(param1);
      },function():ILobbyLayoutService {
        return BattleReadinessServiceImpl.lobbyLayoutService;
      });
      osgi.injectService(IModalLoaderService,function(param1:Object):void {
        BattleReadinessServiceImpl.modalLoaderService = IModalLoaderService(param1);
      },function():IModalLoaderService {
        return BattleReadinessServiceImpl.modalLoaderService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BonusRegionService.battleService = BattleService(param1);
      },function():BattleService {
        return BonusRegionService.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        BonusRegionService.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return BonusRegionService.materialRegistry;
      });
      osgi.injectService(ISettingsService,function(param1:Object):void {
        BonusRegionService.settings = ISettingsService(param1);
      },function():ISettingsService {
        return BonusRegionService.settings;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        BonusCrystalsEffectUtils.battleService = BattleService(param1);
      },function():BattleService {
        return BonusCrystalsEffectUtils.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        BonusCrystalsEffectUtils.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return BonusCrystalsEffectUtils.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DecalEffect.battleService = BattleService(param1);
      },function():BattleService {
        return DecalEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        LevelUpEffectFactory.battleService = BattleService(param1);
      },function():BattleService {
        return LevelUpEffectFactory.battleService;
      });
      osgi.injectService(TextureMaterialRegistry,function(param1:Object):void {
        LevelUpEffectFactory.materialRegistry = TextureMaterialRegistry(param1);
      },function():TextureMaterialRegistry {
        return LevelUpEffectFactory.materialRegistry;
      });
      osgi.injectService(IUserInfoService,function(param1:Object):void {
        LevelUpEffectFactory.userInfoService = IUserInfoService(param1);
      },function():IUserInfoService {
        return LevelUpEffectFactory.userInfoService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        Sound3DEffect.battleService = BattleService(param1);
      },function():BattleService {
        return Sound3DEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DamageIndicatorEffect.battleService = BattleService(param1);
      },function():BattleService {
        return DamageIndicatorEffect.battleService;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        DroneExplosionModel.battleService = BattleService(param1);
      },function():BattleService {
        return DroneExplosionModel.battleService;
      });
      osgi.injectService(EffectsMaterialRegistry,function(param1:Object):void {
        DroneExplosionModel.materialRegistry = EffectsMaterialRegistry(param1);
      },function():EffectsMaterialRegistry {
        return DroneExplosionModel.materialRegistry;
      });
      osgi.injectService(BattleService,function(param1:Object):void {
        FloatingTextEffect.battleService = BattleService(param1);
      },function():BattleService {
        return FloatingTextEffect.battleService;
      });
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(CustomTurretSkin,CustomTurretSkinAdapt);
      modelRegisterAdapt.registerEvents(CustomTurretSkin,CustomTurretSkinEvents);
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new AssaultModel());
      modelRegisterAdapt.registerAdapt(BattleModel,BattleModelAdapt);
      modelRegisterAdapt.registerEvents(BattleModel,BattleModelEvents);
      modelRegisterAdapt.registerAdapt(BattleSfx,BattleSfxAdapt);
      modelRegisterAdapt.registerEvents(BattleSfx,BattleSfxEvents);
      modelRegisterAdapt.registerAdapt(BattlefieldEvents,BattlefieldEventsAdapt);
      modelRegisterAdapt.registerEvents(BattlefieldEvents,BattlefieldEventsEvents);
      modelRegister.add(new BattlefieldModel());
      modelRegister.add(new BillboardsModel());
      modelRegister.add(new BillboardImageModel());
      modelRegister.add(new BattleMinesModel());
      modelRegisterAdapt.registerAdapt(IBattleMinesModel,IBattleMinesModelAdapt);
      modelRegisterAdapt.registerEvents(IBattleMinesModel,IBattleMinesModelEvents);
      modelRegisterAdapt.registerAdapt(FlagNotification,FlagNotificationAdapt);
      modelRegisterAdapt.registerEvents(FlagNotification,FlagNotificationEvents);
      modelRegisterAdapt.registerAdapt(ICommonFlagModeModel,ICommonFlagModeModelAdapt);
      modelRegisterAdapt.registerEvents(ICommonFlagModeModel,ICommonFlagModeModelEvents);
      modelRegisterAdapt.registerAdapt(IFlagModeInitilizer,IFlagModeInitilizerAdapt);
      modelRegisterAdapt.registerEvents(IFlagModeInitilizer,IFlagModeInitilizerEvents);
      modelRegister.add(new PointBasedBattleModel());
      modelRegister.add(new CTFModel());
      modelRegister.add(new BattleDebugModel());
      modelRegister.add(new BattleDMModel());
      modelRegisterAdapt.registerAdapt(BattleFacilities,BattleFacilitiesAdapt);
      modelRegisterAdapt.registerEvents(BattleFacilities,BattleFacilitiesEvents);
      modelRegisterAdapt.registerAdapt(BattleFacilitiesChecker,BattleFacilitiesCheckerAdapt);
      modelRegisterAdapt.registerEvents(BattleFacilitiesChecker,BattleFacilitiesCheckerEvents);
      modelRegister.add(new BattleFacilitiesModel());
      modelRegisterAdapt.registerAdapt(BattleUnloadListener,BattleUnloadListenerAdapt);
      modelRegisterAdapt.registerEvents(BattleUnloadListener,BattleUnloadListenerEvents);
      modelRegister.add(new CommonFacilityModel());
      modelRegisterAdapt.registerAdapt(FacilityDispellEffect,FacilityDispellEffectAdapt);
      modelRegisterAdapt.registerEvents(FacilityDispellEffect,FacilityDispellEffectEvents);
      modelRegisterAdapt.registerAdapt(FacilitySphericalZone,FacilitySphericalZoneAdapt);
      modelRegisterAdapt.registerEvents(FacilitySphericalZone,FacilitySphericalZoneEvents);
      modelRegister.add(new FacilitySphericalZoneModel());
      modelRegisterAdapt.registerAdapt(ICommonFacility,ICommonFacilityAdapt);
      modelRegisterAdapt.registerEvents(ICommonFacility,ICommonFacilityEvents);
      modelRegisterAdapt.registerAdapt(BattlefieldGUI,BattlefieldGUIAdapt);
      modelRegisterAdapt.registerEvents(BattlefieldGUI,BattlefieldGUIEvents);
      modelRegister.add(new BattleChatModel());
      modelRegisterAdapt.registerAdapt(IBattleChat,IBattleChatAdapt);
      modelRegisterAdapt.registerEvents(IBattleChat,IBattleChatEvents);
      modelRegister.add(new DroneIndicatorModel());
      modelRegisterAdapt.registerAdapt(IDroneModel,IDroneModelAdapt);
      modelRegisterAdapt.registerEvents(IDroneModel,IDroneModelEvents);
      modelRegister.add(new MatchmakingGroupInfoModel());
      modelRegisterAdapt.registerAdapt(IInventoryItem,IInventoryItemAdapt);
      modelRegisterAdapt.registerEvents(IInventoryItem,IInventoryItemEvents);
      modelRegister.add(new InventoryItemModel());
      modelRegister.add(new InventoryModel());
      modelRegister.add(new InventorySfxModel());
      modelRegister.add(new InventoryCooldownModel());
      modelRegister.add(new BattleJGRModel());
      modelRegisterAdapt.registerAdapt(Juggernaut,JuggernautAdapt);
      modelRegisterAdapt.registerEvents(Juggernaut,JuggernautEvents);
      modelRegister.add(new JuggernautModel());
      modelRegister.add(new KillStreakModel());
      modelRegister.add(new MeteorStormModel());
      modelRegister.add(new RugbyModel());
      modelRegisterAdapt.registerAdapt(BallExplosion,BallExplosionAdapt);
      modelRegisterAdapt.registerEvents(BallExplosion,BallExplosionEvents);
      modelRegister.add(new BallExplosionModel());
      modelRegister.add(new MemoryStatisticsModel());
      modelRegister.add(new FpsStatisticsModel());
      modelRegister.add(new TargetingStatisticsModel());
      modelRegister.add(new BattleTDMModel());
      modelRegister.add(new BattlefieldBonusesModel());
      modelRegister.add(new BonusLightModel());
      modelRegisterAdapt.registerAdapt(IBonusLight,IBonusLightAdapt);
      modelRegisterAdapt.registerEvents(IBonusLight,IBonusLightEvents);
      modelRegister.add(new BonusCommonModel());
      modelRegister.add(new BattleGoldBonusesModel());
      modelRegister.add(new GoldBonusesModel());
      modelRegisterAdapt.registerAdapt(IGoldBonus,IGoldBonusAdapt);
      modelRegisterAdapt.registerEvents(IGoldBonus,IGoldBonusEvents);
      modelRegisterAdapt.registerAdapt(BonusNotification,BonusNotificationAdapt);
      modelRegisterAdapt.registerEvents(BonusNotification,BonusNotificationEvents);
      modelRegister.add(new BonusNotificationModel());
      modelRegister.add(new RandomGoldBonusTakeModel());
      modelRegister.add(new BonusRegionsModel());
      modelRegister.add(new ColorAdjustModel());
      modelRegisterAdapt.registerAdapt(IColorAdjust,IColorAdjustAdapt);
      modelRegisterAdapt.registerEvents(IColorAdjust,IColorAdjustEvents);
      modelRegisterAdapt.registerAdapt(ContinueBattle,ContinueBattleAdapt);
      modelRegisterAdapt.registerEvents(ContinueBattle,ContinueBattleEvents);
      modelRegister.add(new ContinueBattleModel());
      modelRegister.add(new MatchmakingContinueBattleModel());
      modelRegister.add(new ControlPointsModel());
      modelRegister.add(new ActiveAfterDeathModel());
      modelRegisterAdapt.registerAdapt(IActiveAfterDeath,IActiveAfterDeathAdapt);
      modelRegisterAdapt.registerEvents(IActiveAfterDeath,IActiveAfterDeathEvents);
      modelRegisterAdapt.registerAdapt(IBonusCommonModel,IBonusCommonModelAdapt);
      modelRegisterAdapt.registerEvents(IBonusCommonModel,IBonusCommonModelEvents);
      modelRegister.add(new EffectDescriptionModel());
      modelRegister.add(new DurationModel());
      modelRegisterAdapt.registerAdapt(IDuration,IDurationAdapt);
      modelRegisterAdapt.registerEvents(IDuration,IDurationEvents);
      modelRegister.add(new EffectLevelModel());
      modelRegisterAdapt.registerAdapt(IEffectLevel,IEffectLevelAdapt);
      modelRegisterAdapt.registerEvents(IEffectLevel,IEffectLevelEvents);
      modelRegisterAdapt.registerAdapt(IInventoryModel,IInventoryModelAdapt);
      modelRegisterAdapt.registerEvents(IInventoryModel,IInventoryModelEvents);
      modelRegister.add(new LatencyModel());
      modelRegister.add(new BattleMapModel());
      modelRegisterAdapt.registerAdapt(IBattleMap,IBattleMapAdapt);
      modelRegisterAdapt.registerEvents(IBattleMap,IBattleMapEvents);
      modelRegisterAdapt.registerAdapt(IMapBonusLight,IMapBonusLightAdapt);
      modelRegisterAdapt.registerEvents(IMapBonusLight,IMapBonusLightEvents);
      modelRegister.add(new MapBonusLightModel());
      modelRegister.add(new PerformanceModel());
      modelRegisterAdapt.registerAdapt(ColorTransformConsumer,ColorTransformConsumerAdapt);
      modelRegisterAdapt.registerEvents(ColorTransformConsumer,ColorTransformConsumerEvents);
      modelRegister.add(new ColorTransformModel());
      modelRegister.add(new TankEffectSFXModel());
      modelRegisterAdapt.registerAdapt(HullSmoke,HullSmokeAdapt);
      modelRegisterAdapt.registerEvents(HullSmoke,HullSmokeEvents);
      modelRegister.add(new HullSmokeModel());
      modelRegisterAdapt.registerAdapt(IClientUserInfo,IClientUserInfoAdapt);
      modelRegisterAdapt.registerEvents(IClientUserInfo,IClientUserInfoEvents);
      modelRegisterAdapt.registerAdapt(IStatisticRound,IStatisticRoundAdapt);
      modelRegisterAdapt.registerEvents(IStatisticRound,IStatisticRoundEvents);
      modelRegisterAdapt.registerAdapt(IStatisticsModel,IStatisticsModelAdapt);
      modelRegisterAdapt.registerEvents(IStatisticsModel,IStatisticsModelEvents);
      modelRegister.add(new StatisticsModel());
      modelRegister.add(new StatisticsDmModel());
      modelRegister.add(new StatisticsTeamModel());
      modelRegisterAdapt.registerAdapt(AddToBattleListener,AddToBattleListenerAdapt);
      modelRegisterAdapt.registerEvents(AddToBattleListener,AddToBattleListenerEvents);
      modelRegisterAdapt.registerAdapt(DestroyTankPart,DestroyTankPartAdapt);
      modelRegisterAdapt.registerEvents(DestroyTankPart,DestroyTankPartEvents);
      modelRegisterAdapt.registerAdapt(ITankModel,ITankModelAdapt);
      modelRegisterAdapt.registerEvents(ITankModel,ITankModelEvents);
      modelRegisterAdapt.registerAdapt(InitTankPart,InitTankPartAdapt);
      modelRegisterAdapt.registerEvents(InitTankPart,InitTankPartEvents);
      modelRegisterAdapt.registerAdapt(RemoveFromBattleListener,RemoveFromBattleListenerAdapt);
      modelRegisterAdapt.registerEvents(RemoveFromBattleListener,RemoveFromBattleListenerEvents);
      modelRegister.add(new TankModel());
      modelRegisterAdapt.registerAdapt(TankPartReset,TankPartResetAdapt);
      modelRegisterAdapt.registerEvents(TankPartReset,TankPartResetEvents);
      modelRegisterAdapt.registerAdapt(WeaponMountProvider,WeaponMountProviderAdapt);
      modelRegisterAdapt.registerEvents(WeaponMountProvider,WeaponMountProviderEvents);
      modelRegisterAdapt.registerAdapt(Armor,ArmorAdapt);
      modelRegisterAdapt.registerEvents(Armor,ArmorEvents);
      modelRegister.add(new SimpleArmorModel());
      modelRegisterAdapt.registerAdapt(ITrackedChassis,ITrackedChassisAdapt);
      modelRegisterAdapt.registerEvents(ITrackedChassis,ITrackedChassisEvents);
      modelRegister.add(new TrackedChassisModel());
      modelRegister.add(new BossStateModel());
      modelRegisterAdapt.registerAdapt(IBossState,IBossStateAdapt);
      modelRegisterAdapt.registerEvents(IBossState,IBossStateEvents);
      modelRegisterAdapt.registerAdapt(TankConfiguration,TankConfigurationAdapt);
      modelRegisterAdapt.registerEvents(TankConfiguration,TankConfigurationEvents);
      modelRegister.add(new TankConfigurationModel());
      modelRegister.add(new DamageIndicatorModel());
      modelRegisterAdapt.registerAdapt(TankDevice,TankDeviceAdapt);
      modelRegisterAdapt.registerEvents(TankDevice,TankDeviceEvents);
      modelRegister.add(new TankDeviceModel());
      modelRegisterAdapt.registerAdapt(Engine,EngineAdapt);
      modelRegisterAdapt.registerEvents(Engine,EngineEvents);
      modelRegister.add(new EngineModel());
      modelRegisterAdapt.registerAdapt(LocalTankLoadListener,LocalTankLoadListenerAdapt);
      modelRegisterAdapt.registerEvents(LocalTankLoadListener,LocalTankLoadListenerEvents);
      modelRegisterAdapt.registerAdapt(LocalTankUnloadListener,LocalTankUnloadListenerAdapt);
      modelRegisterAdapt.registerEvents(LocalTankUnloadListener,LocalTankUnloadListenerEvents);
      modelRegisterAdapt.registerAdapt(TankEntityCreationListener,TankEntityCreationListenerAdapt);
      modelRegisterAdapt.registerEvents(TankEntityCreationListener,TankEntityCreationListenerEvents);
      modelRegisterAdapt.registerAdapt(ITankExplosionModel,ITankExplosionModelAdapt);
      modelRegisterAdapt.registerEvents(ITankExplosionModel,ITankExplosionModelEvents);
      modelRegister.add(new TankExplosionModel());
      modelRegister.add(new BattleGearScoreModel());
      modelRegisterAdapt.registerAdapt(GearScoreInfo,GearScoreInfoAdapt);
      modelRegisterAdapt.registerEvents(GearScoreInfo,GearScoreInfoEvents);
      modelRegisterAdapt.registerAdapt(HullCommon,HullCommonAdapt);
      modelRegisterAdapt.registerEvents(HullCommon,HullCommonEvents);
      modelRegister.add(new HullCommonModel());
      modelRegisterAdapt.registerAdapt(ITankPause,ITankPauseAdapt);
      modelRegisterAdapt.registerEvents(ITankPause,ITankPauseEvents);
      modelRegister.add(new TankPauseModel());
      modelRegisterAdapt.registerAdapt(ITankRankUpEffectModel,ITankRankUpEffectModelAdapt);
      modelRegisterAdapt.registerEvents(ITankRankUpEffectModel,ITankRankUpEffectModelEvents);
      modelRegister.add(new TankRankUpEffectModel());
      modelRegister.add(new TankReloaderModel());
      modelRegisterAdapt.registerAdapt(TankResistances,TankResistancesAdapt);
      modelRegisterAdapt.registerEvents(TankResistances,TankResistancesEvents);
      modelRegister.add(new TankResistancesModel());
      modelRegisterAdapt.registerAdapt(ITankSpawner,ITankSpawnerAdapt);
      modelRegisterAdapt.registerEvents(ITankSpawner,ITankSpawnerEvents);
      modelRegister.add(new TankSpawnerModel());
      modelRegisterAdapt.registerAdapt(SpeedCharacteristics,SpeedCharacteristicsAdapt);
      modelRegisterAdapt.registerEvents(SpeedCharacteristics,SpeedCharacteristicsEvents);
      modelRegister.add(new SpeedCharacteristicsModel());
      modelRegister.add(new SuicideModel());
      modelRegister.add(new TankTemperatureModel());
      modelRegister.add(new TankTurnOverModel());
      modelRegisterAdapt.registerAdapt(IUltimateModel,IUltimateModelAdapt);
      modelRegisterAdapt.registerEvents(IUltimateModel,IUltimateModelEvents);
      modelRegister.add(new UltimateModel());
      modelRegister.add(new DictatorUltimateModel());
      modelRegister.add(new HornetUltimateModel());
      modelRegister.add(new BattleUltimateRadarModel());
      modelRegister.add(new HunterUltimateModel());
      modelRegister.add(new TankStunModel());
      modelRegisterAdapt.registerAdapt(UltimateStunListener,UltimateStunListenerAdapt);
      modelRegisterAdapt.registerEvents(UltimateStunListener,UltimateStunListenerEvents);
      modelRegister.add(new JuggernautUltimateModel());
      modelRegisterAdapt.registerAdapt(ImpactEnable,ImpactEnableAdapt);
      modelRegisterAdapt.registerEvents(ImpactEnable,ImpactEnableEvents);
      modelRegister.add(new MammothUltimateModel());
      modelRegister.add(new TitanUltimateGeneratorModel());
      modelRegister.add(new VikingUltimateModel());
      modelRegister.add(new WaspUltimateBombModel());
      modelRegisterAdapt.registerAdapt(IModeLight,IModeLightAdapt);
      modelRegisterAdapt.registerEvents(IModeLight,IModeLightEvents);
      modelRegister.add(new TeamLightModel());
      modelRegister.add(new TimeCheckerModel());
      modelRegisterAdapt.registerAdapt(IWeaponModel,IWeaponModelAdapt);
      modelRegisterAdapt.registerEvents(IWeaponModel,IWeaponModelEvents);
      modelRegisterAdapt.registerAdapt(VerticalAngles,VerticalAnglesAdapt);
      modelRegisterAdapt.registerEvents(VerticalAngles,VerticalAnglesEvents);
      modelRegister.add(new WeaponVerticalAnglesModel());
      modelRegisterAdapt.registerAdapt(VerticalAutoAiming,VerticalAutoAimingAdapt);
      modelRegisterAdapt.registerEvents(VerticalAutoAiming,VerticalAutoAimingEvents);
      modelRegister.add(new VerticalAutoAimingModel());
      modelRegisterAdapt.registerAdapt(ArtilleryEffectsProvider,ArtilleryEffectsProviderAdapt);
      modelRegisterAdapt.registerEvents(ArtilleryEffectsProvider,ArtilleryEffectsProviderEvents);
      modelRegister.add(new ArtilleryModel());
      modelRegisterAdapt.registerAdapt(ArtillerySkin,ArtillerySkinAdapt);
      modelRegisterAdapt.registerEvents(ArtillerySkin,ArtillerySkinEvents);
      modelRegisterAdapt.registerAdapt(ArtilleryVariant,ArtilleryVariantAdapt);
      modelRegisterAdapt.registerEvents(ArtilleryVariant,ArtilleryVariantEvents);
      modelRegisterAdapt.registerAdapt(IArtilleryModel,IArtilleryModelAdapt);
      modelRegisterAdapt.registerEvents(IArtilleryModel,IArtilleryModelEvents);
      modelRegister.add(new ArtilleryElevatingBarrelModel());
      modelRegister.add(new ArtilleryRotatingTurretModel());
      modelRegisterAdapt.registerAdapt(ArtillerySfx,ArtillerySfxAdapt);
      modelRegisterAdapt.registerEvents(ArtillerySfx,ArtillerySfxEvents);
      modelRegister.add(new ArtillerySfxModel());
      modelRegisterAdapt.registerAdapt(IWeaponCommonModel,IWeaponCommonModelAdapt);
      modelRegisterAdapt.registerEvents(IWeaponCommonModel,IWeaponCommonModelEvents);
      modelRegisterAdapt.registerAdapt(WeaponBuffListener,WeaponBuffListenerAdapt);
      modelRegisterAdapt.registerEvents(WeaponBuffListener,WeaponBuffListenerEvents);
      modelRegister.add(new WeaponCommonModel());
      modelRegisterAdapt.registerAdapt(WeaponSound,WeaponSoundAdapt);
      modelRegisterAdapt.registerEvents(WeaponSound,WeaponSoundEvents);
      modelRegister.add(new FlamethrowerModel());
      modelRegister.add(new FlamethrowerSFXModel());
      modelRegisterAdapt.registerAdapt(IFlamethrowerSFXModel,IFlamethrowerSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IFlamethrowerSFXModel,IFlamethrowerSFXModelEvents);
      modelRegister.add(new FreezeModel());
      modelRegister.add(new FreezeSFXModel());
      modelRegisterAdapt.registerAdapt(IFreezeSFXModel,IFreezeSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IFreezeSFXModel,IFreezeSFXModelEvents);
      modelRegister.add(new GaussModel());
      modelRegisterAdapt.registerAdapt(GaussSkin,GaussSkinAdapt);
      modelRegisterAdapt.registerEvents(GaussSkin,GaussSkinEvents);
      modelRegisterAdapt.registerAdapt(GaussWeaponCallback,GaussWeaponCallbackAdapt);
      modelRegisterAdapt.registerEvents(GaussWeaponCallback,GaussWeaponCallbackEvents);
      modelRegister.add(new GaussSFXModel());
      modelRegisterAdapt.registerAdapt(IGaussSFXModel,IGaussSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IGaussSFXModel,IGaussSFXModelEvents);
      modelRegisterAdapt.registerAdapt(HealingGunCallback,HealingGunCallbackAdapt);
      modelRegisterAdapt.registerEvents(HealingGunCallback,HealingGunCallbackEvents);
      modelRegister.add(new HealingGunModel());
      modelRegister.add(new HealingGunSFXModel());
      modelRegisterAdapt.registerAdapt(IHealingGunSFXModel,IHealingGunSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IHealingGunSFXModel,IHealingGunSFXModelEvents);
      modelRegisterAdapt.registerAdapt(LaserPointer,LaserPointerAdapt);
      modelRegisterAdapt.registerEvents(LaserPointer,LaserPointerEvents);
      modelRegister.add(new LaserPointerModel());
      modelRegister.add(new MachineGunModel());
      modelRegisterAdapt.registerAdapt(IMachineGunSFXModel,IMachineGunSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IMachineGunSFXModel,IMachineGunSFXModelEvents);
      modelRegister.add(new MachineGunSFXModel());
      modelRegisterAdapt.registerAdapt(IRailgunSFXModel,IRailgunSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IRailgunSFXModel,IRailgunSFXModelEvents);
      modelRegisterAdapt.registerAdapt(RailgunCallback,RailgunCallbackAdapt);
      modelRegisterAdapt.registerEvents(RailgunCallback,RailgunCallbackEvents);
      modelRegister.add(new RailgunModel());
      modelRegister.add(new RailgunSFXModel());
      modelRegisterAdapt.registerAdapt(IRicochetSFXModel,IRicochetSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IRicochetSFXModel,IRicochetSFXModelEvents);
      modelRegister.add(new RicochetModel());
      modelRegister.add(new RicochetSFXModel());
      modelRegisterAdapt.registerAdapt(RicochetWeaponCallback,RicochetWeaponCallbackAdapt);
      modelRegisterAdapt.registerEvents(RicochetWeaponCallback,RicochetWeaponCallbackEvents);
      modelRegister.add(new RocketLauncherModel());
      modelRegisterAdapt.registerAdapt(RocketExplosion,RocketExplosionAdapt);
      modelRegisterAdapt.registerEvents(RocketExplosion,RocketExplosionEvents);
      modelRegister.add(new RocketLauncherRadioExplosionModel());
      modelRegisterAdapt.registerAdapt(RocketLauncherSfx,RocketLauncherSfxAdapt);
      modelRegisterAdapt.registerEvents(RocketLauncherSfx,RocketLauncherSfxEvents);
      modelRegister.add(new RocketLauncherSfxModel());
      modelRegisterAdapt.registerAdapt(RocketLauncherWeaponProvider,RocketLauncherWeaponProviderAdapt);
      modelRegisterAdapt.registerEvents(RocketLauncherWeaponProvider,RocketLauncherWeaponProviderEvents);
      modelRegisterAdapt.registerAdapt(WeaponRotationLimit,WeaponRotationLimitAdapt);
      modelRegisterAdapt.registerEvents(WeaponRotationLimit,WeaponRotationLimitEvents);
      modelRegister.add(new WeaponRotationLimitModel());
      modelRegisterAdapt.registerAdapt(IShaftSFXModel,IShaftSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IShaftSFXModel,IShaftSFXModelEvents);
      modelRegisterAdapt.registerAdapt(IShaftWeaponCallback,IShaftWeaponCallbackAdapt);
      modelRegisterAdapt.registerEvents(IShaftWeaponCallback,IShaftWeaponCallbackEvents);
      modelRegister.add(new ShaftModel());
      modelRegister.add(new ShaftSFXModel());
      modelRegister.add(new DiscreteShotModel());
      modelRegisterAdapt.registerAdapt(IShotModel,IShotModelAdapt);
      modelRegisterAdapt.registerEvents(IShotModel,IShotModelEvents);
      modelRegisterAdapt.registerAdapt(WeaponReloadTimeChangedListener,WeaponReloadTimeChangedListenerAdapt);
      modelRegisterAdapt.registerEvents(WeaponReloadTimeChangedListener,WeaponReloadTimeChangedListenerEvents);
      modelRegisterAdapt.registerAdapt(IStreamWeaponCallback,IStreamWeaponCallbackAdapt);
      modelRegisterAdapt.registerEvents(IStreamWeaponCallback,IStreamWeaponCallbackEvents);
      modelRegister.add(new ShotgunModel());
      modelRegisterAdapt.registerAdapt(ShotgunAiming,ShotgunAimingAdapt);
      modelRegisterAdapt.registerEvents(ShotgunAiming,ShotgunAimingEvents);
      modelRegister.add(new ShotgunAimingModel());
      modelRegisterAdapt.registerAdapt(ShotgunSFX,ShotgunSFXAdapt);
      modelRegisterAdapt.registerEvents(ShotgunSFX,ShotgunSFXEvents);
      modelRegister.add(new ShotgunSFXModel());
      modelRegisterAdapt.registerAdapt(SmokyCallback,SmokyCallbackAdapt);
      modelRegisterAdapt.registerEvents(SmokyCallback,SmokyCallbackEvents);
      modelRegister.add(new SmokyModel());
      modelRegisterAdapt.registerAdapt(ISmokySFXModel,ISmokySFXModelAdapt);
      modelRegisterAdapt.registerEvents(ISmokySFXModel,ISmokySFXModelEvents);
      modelRegister.add(new SmokySFXModel());
      modelRegisterAdapt.registerAdapt(Splash,SplashAdapt);
      modelRegisterAdapt.registerEvents(Splash,SplashEvents);
      modelRegister.add(new SplashModel());
      modelRegisterAdapt.registerAdapt(IStreamWeaponModel,IStreamWeaponModelAdapt);
      modelRegisterAdapt.registerEvents(IStreamWeaponModel,IStreamWeaponModelEvents);
      modelRegister.add(new StreamWeaponModel());
      modelRegisterAdapt.registerAdapt(StreamWeaponReconfiguredListener,StreamWeaponReconfiguredListenerAdapt);
      modelRegisterAdapt.registerEvents(StreamWeaponReconfiguredListener,StreamWeaponReconfiguredListenerEvents);
      modelRegisterAdapt.registerAdapt(Terminator,TerminatorAdapt);
      modelRegisterAdapt.registerEvents(Terminator,TerminatorEvents);
      modelRegister.add(new TerminatorModel());
      modelRegisterAdapt.registerAdapt(TerminatorSkin,TerminatorSkinAdapt);
      modelRegisterAdapt.registerEvents(TerminatorSkin,TerminatorSkinEvents);
      modelRegisterAdapt.registerAdapt(TerminatorSFX,TerminatorSFXAdapt);
      modelRegisterAdapt.registerEvents(TerminatorSFX,TerminatorSFXEvents);
      modelRegister.add(new TerminatorSFXModel());
      modelRegisterAdapt.registerAdapt(IThunderSFXModel,IThunderSFXModelAdapt);
      modelRegisterAdapt.registerEvents(IThunderSFXModel,IThunderSFXModelEvents);
      modelRegisterAdapt.registerAdapt(ThunderCallback,ThunderCallbackAdapt);
      modelRegisterAdapt.registerEvents(ThunderCallback,ThunderCallbackEvents);
      modelRegister.add(new ThunderModel());
      modelRegister.add(new ThunderSFXModel());
      modelRegisterAdapt.registerAdapt(IRotatingTurretModel,IRotatingTurretModelAdapt);
      modelRegisterAdapt.registerEvents(IRotatingTurretModel,IRotatingTurretModelEvents);
      modelRegister.add(new RotatingTurretModel());
      modelRegisterAdapt.registerAdapt(TurretStateSender,TurretStateSenderAdapt);
      modelRegisterAdapt.registerEvents(TurretStateSender,TurretStateSenderEvents);
      modelRegisterAdapt.registerAdapt(ITwinsSFXModel,ITwinsSFXModelAdapt);
      modelRegisterAdapt.registerEvents(ITwinsSFXModel,ITwinsSFXModelEvents);
      modelRegister.add(new TwinsModel());
      modelRegister.add(new TwinsSFXModel());
      modelRegisterAdapt.registerAdapt(TwinsWeaponCallback,TwinsWeaponCallbackAdapt);
      modelRegisterAdapt.registerEvents(TwinsWeaponCallback,TwinsWeaponCallbackEvents);
      modelRegisterAdapt.registerAdapt(IWeaponWeakeningModel,IWeaponWeakeningModelAdapt);
      modelRegisterAdapt.registerEvents(IWeaponWeakeningModel,IWeaponWeakeningModelEvents);
      modelRegister.add(new WeaponWeakeningModel());
      modelRegisterAdapt.registerAdapt(WeaponChargingCommunication,WeaponChargingCommunicationAdapt);
      modelRegisterAdapt.registerEvents(WeaponChargingCommunication,WeaponChargingCommunicationEvents);
      modelRegister.add(new WeaponChargingCommunicationModel());
      modelRegisterAdapt.registerAdapt(WeaponChargingListener,WeaponChargingListenerAdapt);
      modelRegisterAdapt.registerEvents(WeaponChargingListener,WeaponChargingListenerEvents);
      modelRegisterAdapt.registerAdapt(DiscreteWeapon,DiscreteWeaponAdapt);
      modelRegisterAdapt.registerEvents(DiscreteWeapon,DiscreteWeaponEvents);
      modelRegister.add(new DiscreteWeaponCommunicationModel());
      modelRegisterAdapt.registerAdapt(DiscreteWeaponListener,DiscreteWeaponListenerAdapt);
      modelRegisterAdapt.registerEvents(DiscreteWeaponListener,DiscreteWeaponListenerEvents);
      modelRegisterAdapt.registerAdapt(ShellWeaponCommunication,ShellWeaponCommunicationAdapt);
      modelRegisterAdapt.registerEvents(ShellWeaponCommunication,ShellWeaponCommunicationEvents);
      modelRegister.add(new ShellWeaponCommunicationModel());
      modelRegisterAdapt.registerAdapt(ShellWeaponListener,ShellWeaponListenerAdapt);
      modelRegisterAdapt.registerEvents(ShellWeaponListener,ShellWeaponListenerEvents);
      modelRegisterAdapt.registerAdapt(TargetShellWeaponListener,TargetShellWeaponListenerAdapt);
      modelRegisterAdapt.registerEvents(TargetShellWeaponListener,TargetShellWeaponListenerEvents);
      modelRegisterAdapt.registerAdapt(StreamWeaponCommunication,StreamWeaponCommunicationAdapt);
      modelRegisterAdapt.registerEvents(StreamWeaponCommunication,StreamWeaponCommunicationEvents);
      modelRegister.add(new StreamWeaponCommunicationModel());
      modelRegisterAdapt.registerAdapt(StreamWeaponListener,StreamWeaponListenerAdapt);
      modelRegisterAdapt.registerEvents(StreamWeaponListener,StreamWeaponListenerEvents);
      modelRegister.add(new DroneExplosionModel());
      modelRegisterAdapt.registerAdapt(DroneSFX,DroneSFXAdapt);
      modelRegisterAdapt.registerEvents(DroneSFX,DroneSFXEvents);
      modelRegister.add(new DroneSFXModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
