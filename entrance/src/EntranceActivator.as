package {
  import alternativa.init.BattleSelectModelActivator;
  import alternativa.init.ChatModelActivator;
  import alternativa.init.ClansModelActivator;
  import alternativa.init.CommonsActivator;
  import alternativa.init.PanelModelActivator;
  import alternativa.init.TanksFontsActivator;
  import alternativa.init.TanksServicesActivator;
  import alternativa.init.UserModelActivator;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import init.TanksFormsActivator;
  import platform.client.core.general.pushnotification.osgi.Activator;
  import platform.client.core.general.resource.osgi.Activator;
  import platform.client.core.general.socialnetwork.osgi.Activator;
  import platform.client.core.general.spaces.osgi.Activator;
  import platform.client.fp10.core.osgi.ClientActivator;
  import platform.client.models.commons.osgi.Activator;
  import platform.clients.fp10.commonsflash.Activator;
  import platform.clients.fp10.libraries.alternativaclientflash.Activator;
  import platform.clients.fp10.libraries.alternativapartners.osgi.PartnersActivator;
  import platform.clients.fp10.libraries.alternativapartnersflash.Activator;
  import platform.clients.fp10.models.alternativaspacesmodelsflash.Activator;
  import platform.loading.init.SpacesModelsActivator;
  import projects.tanks.client.achievements.osgi.Activator;
  import projects.tanks.client.battleselect.osgi.Activator;
  import projects.tanks.client.battleservice.osgi.Activator;
  import projects.tanks.client.chat.osgi.Activator;
  import projects.tanks.client.clans.osgi.Activator;
  import projects.tanks.client.commons.osgi.Activator;
  import projects.tanks.client.entrance.osgi.Activator;
  import projects.tanks.client.panel.osgi.Activator;
  import projects.tanks.client.partners.osgi.Activator;
  import projects.tanks.client.tanksservices.osgi.Activator;
  import projects.tanks.client.users.osgi.Activator;
  import projects.tanks.clients.flash.commons.osgi.Activator;
  import projects.tanks.clients.flash.commonsflash.Activator;
  import projects.tanks.clients.fp10.libraries.tanksservicesflash.Activator;
  import projects.tanks.clients.fp10.models.clansmodelflash.Activator;
  import projects.tanks.clients.fp10.models.tanksbattleselectmodelflash.Activator;
  import projects.tanks.clients.fp10.models.tankschatmodelflash.Activator;
  import projects.tanks.clients.fp10.models.tankspanelmodelflash.Activator;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.init.PartnersModelActivator;
  import projects.tanks.clients.fp10.models.tankspartnersmodelflash.Activator;
  import projects.tanks.clients.fp10.models.tanksusermodelflash.Activator;
  import projects.tanks.clients.fp10.tanksformsflash.Activator;

  public class EntranceActivator implements IBundleActivator {
    public function EntranceActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      new ClientActivator().start(param1);
      new platform.clients.fp10.libraries.alternativaclientflash.Activator().start(param1);
      new platform.client.core.general.resource.osgi.Activator().start(param1);
      new platform.client.core.general.spaces.osgi.Activator().start(param1);
      new platform.client.core.general.pushnotification.osgi.Activator().start(param1);
      new SpacesModelsActivator().start(param1);
      new platform.clients.fp10.models.alternativaspacesmodelsflash.Activator().start(param1);
      new projects.tanks.client.chat.osgi.Activator().start(param1);
      new platform.client.core.general.socialnetwork.osgi.Activator().start(param1);
      new projects.tanks.client.battleservice.osgi.Activator().start(param1);
      new projects.tanks.client.tanksservices.osgi.Activator().start(param1);
      new PartnersActivator().start(param1);
      new platform.clients.fp10.libraries.alternativapartnersflash.Activator().start(param1);
      new TanksFontsActivator().start(param1);
      new projects.tanks.client.users.osgi.Activator().start(param1);
      new projects.tanks.client.commons.osgi.Activator().start(param1);
      new platform.client.models.commons.osgi.Activator().start(param1);
      new TanksServicesActivator().start(param1);
      new projects.tanks.clients.fp10.libraries.tanksservicesflash.Activator().start(param1);
      new TanksFormsActivator().start(param1);
      new projects.tanks.clients.fp10.tanksformsflash.Activator().start(param1);
      new projects.tanks.clients.flash.commons.osgi.Activator().start(param1);
      new projects.tanks.clients.flash.commonsflash.Activator().start(param1);
      new projects.tanks.client.achievements.osgi.Activator().start(param1);
      new projects.tanks.client.panel.osgi.Activator().start(param1);
      new PanelModelActivator().start(param1);
      new projects.tanks.clients.fp10.models.tankspanelmodelflash.Activator().start(param1);
      new projects.tanks.client.partners.osgi.Activator().start(param1);
      new projects.tanks.client.entrance.osgi.Activator().start(param1);
      new PartnersModelActivator().start(param1);
      new projects.tanks.clients.fp10.models.tankspartnersmodelflash.Activator().start(param1);
      new UserModelActivator().start(param1);
      new projects.tanks.clients.fp10.models.tanksusermodelflash.Activator().start(param1);
      new CommonsActivator().start(param1);
      new platform.clients.fp10.commonsflash.Activator().start(param1);
      new ChatModelActivator().start(param1);
      new projects.tanks.clients.fp10.models.tankschatmodelflash.Activator().start(param1);
      new projects.tanks.client.clans.osgi.Activator().start(param1);
      new ClansModelActivator().start(param1);
      new projects.tanks.clients.fp10.models.clansmodelflash.Activator().start(param1);
      new projects.tanks.client.battleselect.osgi.Activator().start(param1);
      new BattleSelectModelActivator().start(param1);
      new projects.tanks.clients.fp10.models.tanksbattleselectmodelflash.Activator().start(param1);
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
