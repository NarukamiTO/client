package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.protocol.IProtocol;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventDispatcherImpl;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.objects.tank.skintexturesregistry.DefaultTankSkinTextureRegistry;
  import alternativa.tanks.battle.objects.tank.skintexturesregistry.TankSkinTextureRegistry;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkinTextureRegistryCleaner;
  import alternativa.tanks.engine3d.ColorCorrectedTextureRegistry;
  import alternativa.tanks.engine3d.DefaultColorCorrectedTextureRegistry;
  import alternativa.tanks.engine3d.DefaultEffectsMaterialRegistry;
  import alternativa.tanks.engine3d.DefaultTextureMaterialFactory;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.MutableTextureMaterialRegistry;
  import alternativa.tanks.engine3d.MutableTextureRegistryCleaner;
  import alternativa.tanks.engine3d.TextureMaterialRegistryBase;
  import alternativa.tanks.engine3d.TextureMaterialRegistryCleaner;
  import alternativa.tanks.models.battle.battlefield.BattleUnloadEvent;
  import alternativa.tanks.models.tank.codec.MoveCommandCodec;
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
  import alternativa.tanks.services.colortransform.impl.HardwareColorTransformService;
  import alternativa.tanks.services.colortransform.impl.SoftwareColorTransformService;
  import alternativa.tanks.services.initialeffects.IInitialEffectsService;
  import alternativa.tanks.services.initialeffects.InitialEffectsService;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.tanks.services.lightingeffects.LightingEffectsService;
  import alternativa.tanks.services.memoryleakguard.MemoryLeakTrackerService;
  import alternativa.tanks.services.mipmapping.MipMappingService;
  import alternativa.tanks.services.mipmapping.impl.DefaultMipMappingService;
  import alternativa.tanks.services.performance.PerformanceDataService;
  import alternativa.tanks.services.performance.PerformanceDataServiceImpl;
  import alternativa.tanks.services.ping.PingService;
  import alternativa.tanks.services.ping.PingServiceImpl;
  import alternativa.tanks.services.spectatorservice.SpectatorService;
  import alternativa.tanks.services.spectatorservice.SpectatorServiceImpl;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.tanks.services.tankregistry.TankUsersRegistryServiceImpl;
  import alternativa.tanks.utils.DataValidator;
  import alternativa.tanks.utils.DataValidatorImpl;
  import alternativa.utils.TextureMaterialRegistry;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  [Obfuscation(rename="false")]
  public class BattlefieldModelActivator implements IBundleActivator {
    private var osgi:OSGi;

    public function BattlefieldModelActivator() {
      super();
    }

    private static function bytesToMegabytes(param1:Number) : int {
      return param1 / (1024 * 1024);
    }

    [Obfuscation(rename="false")]
    public function start(param1:OSGi) : void {
      this.osgi = param1;
      param1.registerService(MemoryLeakTrackerService,new MemoryLeakTrackerService(param1));
      var local2:BattleEventDispatcher = new BattleEventDispatcherImpl();
      param1.registerService(BattleEventDispatcher,local2);
      param1.registerService(BattleReadinessService,new BattleReadinessServiceImpl());
      var local3:IDisplay = IDisplay(param1.getService(IDisplay));
      var local4:KeysBindingService = KeysBindingService(param1.getService(KeysBindingService));
      param1.registerService(BattleInputService,new BattleInputServiceImpl(local3.stage,local4));
      param1.registerService(SpectatorService,new SpectatorServiceImpl());
      param1.registerService(BattleGUIService,new BattleGUIServiceImpl());
      param1.registerService(PingService,new PingServiceImpl());
      param1.registerService(PerformanceDataService,new PerformanceDataServiceImpl());
      param1.registerService(TankUsersRegistry,new TankUsersRegistryServiceImpl());
      param1.registerService(IBonusRegionService,new BonusRegionService(local2));
      param1.registerService(ILightingEffectsService,new LightingEffectsService());
      this.registerMipMappingService();
      this.registerColorTransformService();
      this.registerEffectsMaterialService();
      this.registerColorCorrectedTextureService();
      this.registerTextureMaterialService();
      this.registerTankSkinTextureService();
      param1.registerService(DataValidator,new DataValidatorImpl(param1));
      param1.registerService(IInitialEffectsService,new InitialEffectsService());
      this.registerMoveCommandCodec();
    }

    private function registerMipMappingService() : void {
      this.osgi.registerService(MipMappingService,new DefaultMipMappingService());
    }

    private function registerColorTransformService() : void {
      if(!GPUCapabilities.gpuEnabled || Boolean(GPUCapabilities.constrained)) {
        this.osgi.registerService(ColorTransformService,new SoftwareColorTransformService());
      } else {
        this.osgi.registerService(ColorTransformService,new HardwareColorTransformService());
      }
    }

    private function registerEffectsMaterialService() : void {
      var local1:DefaultEffectsMaterialRegistry = new DefaultEffectsMaterialRegistry();
      this.osgi.registerService(EffectsMaterialRegistry,local1);
      this.enableMipMappingControl(local1);
      this.registerBattleEventListener(BattleUnloadEvent,new TextureMaterialRegistryCleaner(local1));
    }

    private function _showMaterialRegistryStat(param1:TextureMaterialRegistryBase) : Function {
      var materialRegistry:TextureMaterialRegistryBase = param1;
      return function(param1:FormattedOutput):void {
      };
    }

    private function getCommandService() : CommandService {
      return CommandService(this.osgi.getService(CommandService));
    }

    private function registerColorCorrectedTextureService() : void {
      var local1:ColorCorrectedTextureRegistry = new DefaultColorCorrectedTextureRegistry();
      this.osgi.registerService(ColorCorrectedTextureRegistry,local1);
      this.registerBattleEventListener(BattleUnloadEvent,new MutableTextureRegistryCleaner(local1));
      var local2:ColorTransformService = ColorTransformService(this.osgi.getService(ColorTransformService));
      local2.addColorTransformer(local1);
    }

    private function registerTextureMaterialService() : void {
      var local1:ColorCorrectedTextureRegistry = ColorCorrectedTextureRegistry(this.osgi.getService(ColorCorrectedTextureRegistry));
      var local2:MutableTextureMaterialRegistry = new MutableTextureMaterialRegistry(new DefaultTextureMaterialFactory(),local1);
      this.osgi.registerService(TextureMaterialRegistry,local2);
      this.enableMipMappingControl(local2);
      this.registerBattleEventListener(BattleUnloadEvent,new TextureMaterialRegistryCleaner(local2));
    }

    private function registerTankSkinTextureService() : void {
      var local1:TankSkinTextureRegistry = new DefaultTankSkinTextureRegistry();
      this.osgi.registerService(TankSkinTextureRegistry,local1);
      this.registerBattleEventListener(BattleUnloadEvent,new TankSkinTextureRegistryCleaner(local1));
    }

    private function registerBattleEventListener(param1:Class, param2:BattleEventListener) : void {
      var local3:BattleEventDispatcher = BattleEventDispatcher(this.osgi.getService(BattleEventDispatcher));
      local3.addBattleEventListener(param1,param2);
    }

    private function enableMipMappingControl(param1:TextureMaterialRegistry) : void {
      var local2:MipMappingService = MipMappingService(this.osgi.getService(MipMappingService));
      local2.addMaterialRegistry(param1);
    }

    private function registerMoveCommandCodec() : void {
      var local1:IProtocol = IProtocol(this.osgi.getService(IProtocol));
      local1.registerCodecForType(MoveCommand,new MoveCommandCodec());
    }

    private function traceMemory() : void {
    }

    [Obfuscation(rename="false")]
    public function stop(param1:OSGi) : void {
    }
  }
}
