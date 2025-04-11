package alternativa.osgi.service.command.impl {
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import flash.system.System;

  public class DefaultCommands {
    private var commandService:CommandServiceImpl;

    public function DefaultCommands(param1:CommandService) {
      super();
      this.commandService = param1 as CommandServiceImpl;
      param1.registerCommand("cmd","help","Список всех команд",[],this.cmdList);
      param1.registerCommand("cmd","help","Помощь по конкретной команде",[String],this.cmdHelp);
      param1.registerCommand("cmd","grep","Поиск по строке",[String,Vector],this.cmdGrep);
      param1.registerCommand("cmd","clip","Копировать вывод конвеера в буфер обмена",[Vector],this.cmdClipboard);
    }

    private function cmdList(param1:FormattedOutput) : void {
      var command:Command = null;
      var output:FormattedOutput = param1;
      var sortedCommands:Vector.<Command> = this.commandService.commands.sort(function(param1:Command, param2:Command):Number {
        var local3:* = param1.scope.localeCompare(param2.scope);
        if(local3 != 0) {
          return local3;
        }
        return param1.cmd.localeCompare(param2.cmd);
      });
      var i:int = 0;
      while(i < sortedCommands.length) {
        command = sortedCommands[i];
        output.addText(command.scope + "." + command.cmd);
        i++;
      }
    }

    private function cmdHelp(param1:FormattedOutput, param2:String) : void {
      var local5:Command = null;
      var local3:Boolean = false;
      var local4:int = 0;
      while(local4 < this.commandService.commands.length) {
        local5 = this.commandService.commands[local4];
        if(local5.scope + "." + local5.cmd == param2 || local5.scope + "." + local5.cmd == "cmd." + param2) {
          param1.addText(local5.scope + "." + local5.cmd + " " + local5.help());
          local3 = true;
        }
        local4++;
      }
      if(!local3) {
        param1.addText("Команда не найдена " + param2);
      }
    }

    private function cmdGrep(param1:FormattedOutput, param2:String, param3:Vector.<String>) : void {
      var local4:String = null;
      for each(local4 in param3) {
        if(local4.indexOf(param2) != -1) {
          param1.addText(local4);
        }
      }
    }

    private function cmdClipboard(param1:FormattedOutput, param2:Vector.<String>) : void {
      var local3:String = param2.join("\n");
      System.setClipboard(local3);
      param1.addLines(param2);
    }
  }
}
