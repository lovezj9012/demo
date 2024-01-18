
/*@Observed
class Tasks{
  static id:number=1
  name:string =`任务${Tasks.id++}`
  finished:boolean=false
}*/

class StateTask{
  totalTask:number=0
  finishTask:number=0
}

import {TaskItem} from '../components/TaskItem'
import TaskModel from '../model/TaskModel';
import Tasks from '../viewmodel/Tasks';

@Component
export struct TaskList{
  //属性
  //@Link finishTask: number
  //@Link totalTask: number
  //类
  @Link stateTask:StateTask ;
  @State tasks:Tasks []=[]
  HandTaskChange(){
    this.stateTask.totalTask=this.tasks.length
    this.stateTask.finishTask=this.tasks.filter(t=>t.finished).length
  }

  // 任务信息弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskInfoDialog({onTaskConfirm: this.handleAddTask.bind(this)}),
  })

  async aboutToAppear(){
    //查询任务列表
    console.log('testTag','组件初始化，查询任务列表')
    this.tasks = await TaskModel.getTaskList()
    //更新任务状态
    this.HandTaskChange()
  }

  handleAddTask(name:string){
    //新增任务
    TaskModel.addTask(name)
      .then(id=>{
        console.log('testTag','处理新增任务：',name)
        this.tasks.push(new Tasks(id,name))
        // 2.更新任务完成状态
        this.HandTaskChange()
        // 3.关闭对话框
        this.dialogController.close()
      })
      .catch(err=>{
        console.log('testTag','处理新增任务失败：',name)
      })
  }

  build(){
    Column(){
      Button('新增任务')
        .width(200)
        .onClick(()=>{
          //this.tasks.push(new Tasks())
          //TODO 关系型数据库
          // 打开新增表单对话框
          this.dialogController.open()
        })
        .margin({bottom:20,top:10})

      List({space:10}){
        ForEach(this.tasks,(t:Tasks,index)=>{
          ListItem(){

            TaskItem({t:t,onTaskChange:this.HandTaskChange.bind(this)})
          }
          .swipeAction({end:this.DeleteButton(index)})

        })
      }
      .width('100%')
      .alignListItem(ListItemAlign.Center)
      //.layoutWeight(1)
    }
  }

  @Builder DeleteButton(index:number){
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.White)
    }
    .width(40)
    .height(40)
    .margin({left:6})
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .onClick(()=>{
      //this.tasks.splice(index,1)
      TaskModel.deleteTaskById(this.tasks[ index].id)
        .then(()=>{
          this.tasks.splice(index,1)
          this.HandTaskChange()
          console.log('testTag','处理删除任务成功')
        })
        .catch(err=>{
          console.log('testTag','处理删除任务失败')
        })

    })
  }
}

@CustomDialog
struct TaskInfoDialog{

  name: string = ''
  onTaskConfirm : (name: string) => void
  controller: CustomDialogController

  build(){
    Column({space: 20}){
      TextInput({placeholder: '输入任务名'})
        .onChange(val => this.name = val)
      Row(){
        Button('确定')
          .onClick(() => {
            this.onTaskConfirm(this.name)
          })
        Button('取消')
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(20)
  }
}