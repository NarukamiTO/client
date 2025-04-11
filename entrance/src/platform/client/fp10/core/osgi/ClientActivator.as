package platform.client.fp10.core.osgi {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.protocol.IProtocol;
  import alternativa.types.Long;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.CoreCommands;
  import platform.client.fp10.core.logging.serverlog.ServerLogTarget;
  import platform.client.fp10.core.logging.serverlog.UncaughtErrorServerLog;
  import platform.client.fp10.core.logging.serverlog.UncaughtErrorServerLogImpl;
  import platform.client.fp10.core.network.command.ControlCommand;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.network.connection.ConnectionConnectParameters;
  import platform.client.fp10.core.network.connection.ConnectionInitializers;
  import platform.client.fp10.core.network.connection.ControlConnectionSender;
  import platform.client.fp10.core.network.connection.IConnection;
  import platform.client.fp10.core.network.connection.protection.PrimitiveProtectionContext;
  import platform.client.fp10.core.protocol.codec.ControlRootCodec;
  import platform.client.fp10.core.protocol.codec.DateCodec;
  import platform.client.fp10.core.protocol.codec.GameObjectCodec;
  import platform.client.fp10.core.protocol.codec.SpaceRootCodec;
  import platform.client.fp10.core.registry.GameTypeRegistry;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.registry.impl.GameTypeRegistryImpl;
  import platform.client.fp10.core.registry.impl.ModelsRegistryImpl;
  import platform.client.fp10.core.registry.impl.ResourceRegistryImpl;
  import platform.client.fp10.core.registry.impl.SpaceRegistryImpl;
  import platform.client.fp10.core.resource.IResourceLoader;
  import platform.client.fp10.core.resource.IResourceLocalStorageInternal;
  import platform.client.fp10.core.resource.ResourceLoader;
  import platform.client.fp10.core.resource.ResourceLocalStorage;
  import platform.client.fp10.core.resource.ResourceTimer;
  import platform.client.fp10.core.resource.ResourceType;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SWFLibraryResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.service.IResourceTimer;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.client.fp10.core.service.address.impl.AddressServiceFakeImpl;
  import platform.client.fp10.core.service.address.impl.AddressServiceImpl;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.impl.MessageBoxService;
  import platform.client.fp10.core.service.loadingprogress.ILoadingProgressService;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
  import platform.client.fp10.core.service.serverlog.impl.ServerLogPanel;
  import platform.client.fp10.core.service.transport.ITransportService;
  import platform.client.fp10.core.service.transport.impl.TransportService;
  import platform.client.fp10.core.type.IGameObject;

  public class ClientActivator implements IBundleActivator {
    private var osgi:OSGi;
    private var controlChannelConnection:IConnection;

    public function ClientActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      this.osgi = param1;
      this.registerCodecs();
      this.registerServices();
      this.registerResources();
      setTimeout(this.completeInitialization,0);
    }

    public function stop(param1:OSGi) : void {
    }

    private function registerCodecs() : void {
      var local1:IProtocol = IProtocol(this.osgi.getService(IProtocol));
      local1.registerCodecForType(ControlCommand,new ControlRootCodec());
      local1.registerCodecForType(SpaceCommand,new SpaceRootCodec());
      local1.registerCodecForType(IGameObject,new GameObjectCodec());
      local1.registerCodecForType(Date,new DateCodec());
    }

    private function registerServices() : void {
      this.osgi.registerService(GameTypeRegistry,new GameTypeRegistryImpl());
      this.osgi.registerService(SpaceRegistry,new SpaceRegistryImpl());
      this.osgi.registerService(ModelRegistry,new ModelsRegistryImpl(this.osgi));
      this.osgi.registerServiceMulti([IResourceLocalStorage,IResourceLocalStorageInternal],new ResourceLocalStorage(this.osgi));
      this.osgi.registerService(IResourceLoader,new ResourceLoader(this.osgi));
      this.osgi.registerServiceMulti([ResourceRegistry,ILoadingProgressService],new ResourceRegistryImpl(this.osgi));
      this.osgi.registerService(IErrorMessageService,new MessageBoxService(this.osgi));
      var local1:ILauncherParams = ILauncherParams(this.osgi.getService(ILauncherParams));
      this.osgi.registerService(AddressService,Boolean(local1.getParameter("noswfaddress")) ? new AddressServiceFakeImpl() : new AddressServiceImpl());
      this.osgi.registerService(IResourceTimer,new ResourceTimer(this.osgi));
      this.osgi.registerService(ITransportService,new TransportService());
    }

    private function registerResources() : void {
      var local1:ResourceRegistry = ResourceRegistry(this.osgi.getService(ResourceRegistry));
      local1.registerTypeClasses(ResourceType.SWF_LIBRARY,SWFLibraryResource);
      local1.registerTypeClasses(ResourceType.IMAGE,ImageResource);
      local1.registerTypeClasses(ResourceType.LOCALIZED_IMAGE,LocalizedImageResource);
      local1.registerTypeClasses(ResourceType.MULTIFRAME_IMAGE,MultiframeTextureResource);
      local1.registerTypeClasses(ResourceType.SOUND,SoundResource);
      local1.registerTypeClasses(ResourceType.TEXTURE,TextureResource);
    }

    private function createConnection() : void {
      var local1:IProtocol = IProtocol(this.osgi.getService(IProtocol));
      var local2:ITransportService = ITransportService(this.osgi.getService(ITransportService));
      var local3:INetworkService = INetworkService(this.osgi.getService(INetworkService));
      var local4:ConnectionInitializers = new ConnectionInitializers(local1,new ControlRootCodec(),local2.controlCommandHandler,local3.secure,Long.ZERO,PrimitiveProtectionContext.INSTANCE);
      this.controlChannelConnection = local2.createConnection(local4);
    }

    private function setupServerLog() : void {
      var local4:ServerLogTarget = null;
      var local5:IDisplay = null;
      var local1:LogService = LogService(this.osgi.getService(LogService));
      var local2:ILauncherParams = ILauncherParams(this.osgi.getService(ILauncherParams));
      var local3:String = local2.getParameter("log_to_server");
      if(Boolean(local3)) {
        local4 = new ServerLogTarget(new ControlConnectionSender(),local3);
        local1.addLogTarget(local4);
        if(Boolean(local2.getParameter("show_server_logs"))) {
          local5 = IDisplay(this.osgi.getService(IDisplay));
          local4.setLogPanel(new ServerLogPanel(local5.stage));
        }
      }
    }

    private function completeInitialization() : void {
      this.registerCommmands();
      this.createConnection();
      this.setupServerLog();
      this.connectToServer();
      this.setupUncaughtErrorLogSender();
    }

    private function registerCommmands() : void {
      new CoreCommands();
    }

    private function connectToServer() : void {
      var local1:INetworkService = INetworkService(this.osgi.getService(INetworkService));
      this.controlChannelConnection.connect(new ConnectionConnectParameters(local1.controlServerAddress,local1.controlServerPorts));
    }

    private function setupUncaughtErrorLogSender() : void {
      this.osgi.registerService(UncaughtErrorServerLog,new UncaughtErrorServerLogImpl(new ControlConnectionSender()));
    }
  }
}
