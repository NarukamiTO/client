package alternativa.tanks.utils {
  import flash.events.Event;
  import flash.events.EventDispatcher;

  public class TaskSequence extends EventDispatcher {
    private var tasks:Vector.<Task>;
    private var currentTask:int;
    private var killed:Boolean;

    public function TaskSequence() {
      super();
      this.tasks = new Vector.<Task>();
    }

    public function kill() : void {
      this.killed = true;
    }

    public function addTask(param1:Task) : void {
      if(this.tasks.indexOf(param1) < 0) {
        this.tasks.push(param1);
        param1.taskSequence = this;
      }
    }

    public function run() : void {
      if(this.tasks.length > 0) {
        this.currentTask = 0;
        this.runCurrentTask();
      } else {
        this.tasks = null;
        dispatchEvent(new Event(Event.COMPLETE));
      }
    }

    private function runCurrentTask() : void {
      var local1:Task = this.tasks[this.currentTask];
      local1.run();
    }

    internal function taskComplete(param1:Task) : void {
      if(!this.killed) {
        if(++this.currentTask < this.tasks.length) {
          this.runCurrentTask();
        } else {
          dispatchEvent(new Event(Event.COMPLETE));
        }
      }
    }
  }
}
