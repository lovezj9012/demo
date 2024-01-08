
import {TaskStaty} from '../components/TaskStatify'
import { TaskList} from '../components/TaskList'

class StateTask{
  totalTask:number=0
  finishTask:number=0
}

@Entry
@Component
struct PropPage{
  //@State totalTask:number=0
  //@State finishTask:number=0

  @State stateTask:StateTask =new StateTask()

  build(){
    Column(){
      //属性字段
      //TaskStaty({totalTask:this.totalTask,finishTask:this.finishTask})
      //TaskList({totalTask:$totalTask,finishTask:$finishTask})

      //类
      TaskStaty({totalTask:this.stateTask.totalTask,finishTask:this.stateTask.finishTask})

      TaskList({stateTask:$stateTask})
        .layoutWeight(1)


    }
  }
}