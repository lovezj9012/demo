
import promptAction from '@ohos.promptAction'
import notify from '@ohos.notificationManager'
import wantAgent, { WantAgent } from '@ohos.app.ability.wantAgent'
enum DownloadState{
  NOT_BEGIN='未开始',
  DOWNLOADING='下载中',
  PAUSE='已暂停',
  FINISHED='已完成'
}

@Extend(Button) function downloadButton() {
  .width(75).height(28).fontSize(14)
}


@Component
export default struct DownloadCard{

  //下载进度
  @State progressValue:number=0
  //任务状态
  @State state:DownloadState=DownloadState.NOT_BEGIN

  //下载文件名称
  filename:string='test.mp4'
  //定时任务id
  taskId:number=-1
  //通知id
  notificationId:number=110

  isSupport:boolean=false

  wantAgentInstance:WantAgent

  async aboutToAppear(){
    //判断是否支持进度条末班
    this.isSupport = await notify.isSupportTemplate('downloadTemplate')
    //创建拉去当前引用的行为意图
    //创建wantinfo信息
    let wantInfo: wantAgent.WantAgentInfo={
      wants:[
        {
          deviceId:'',
          bundleName:'com.zj.demo',
          abilityName:'EntryAbility'
        }
      ],
      requestCode:0,
      operationType:wantAgent.OperationType.START_ABILITY,
      wantAgentFlags:[wantAgent.WantAgentFlags.CONSTANT_FLAG]
    }
    //创建wantInstance实例
     this.wantAgentInstance = await wantAgent.getWantAgent(wantInfo)
  }

  build() {
    Row({ space: 10 }) {
      Image($r('app.media.ic_files_doc')).width((50))
      Column({ space: 5 }) {
        Row() {
          Text(this.filename)
          Text(`${this.progressValue}%`).fontColor('#c1c2c1')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Progress({
          value: this.progressValue,
          total: 100
        })

        Row({ space: 5 }) {
          Text(`${(this.progressValue * 0.43).toFixed(2)}MB`)
            .fontSize(14).fontColor('#c1c2c1')
          Blank()
          if (this.state === DownloadState.NOT_BEGIN) {
            Button('开始')
              .downloadButton()
              .onClick(() => {
                this.download()
              })
          } else if (this.state == DownloadState.DOWNLOADING) {
            Button('暂停')
              .downloadButton()
              .onClick(() => {
                this.pause()
              })

            Button('取消')
              .downloadButton()
              .backgroundColor('#d1d2d3')
              .onClick(() => {
                this.cancel()
              })
          } else if (this.state === DownloadState.PAUSE) {
            Button('继续')
              .downloadButton()
              .onClick(() => {
                this.download()
              })

            Button('取消')
              .downloadButton()
              .backgroundColor('#d1d2d3')
              .onClick(() => {
                this.cancel()
              })
          } else {
            Button('打开')
              .downloadButton()
              .onClick(() => {
                this.open()
              })
          }
        }
        .width('100%')

      }
      .layoutWeight(1)

    }
    .width('100%')
    .borderRadius(20)
    .padding(15)
    .backgroundColor(Color.White)

  }

  cancel(){

    //取消任务
    if(this.taskId>0) {
      clearInterval(this.taskId)
      this.taskId=-1
    }
    //清理下载任务进度
    this.progressValue=0

    this.state=DownloadState.NOT_BEGIN

    //取消通知
    notify.cancel(this.notificationId)
  }

  download(){
    //清理旧任务
    if(this.taskId>0){
      clearInterval(this.taskId)
    }
    //开启定时任务，模拟下载
     this.taskId = setInterval(()=>{
      if(this.progressValue>=100) {
        clearInterval(this.taskId)
        this.taskId=-1
        this.state=DownloadState.FINISHED
        //发送通知
        this.publishDownLoadNotification()
        return
      }
      this.progressValue += 2
       //发送通知
       this.publishDownLoadNotification()
    },500)
    this.state=DownloadState.DOWNLOADING


  }

  pause(){
    //取消任务
    if(this.taskId>0) {
      clearInterval(this.taskId)
      this.taskId=-1
    }
    this.state=DownloadState.PAUSE
    //发送通知
    this.publishDownLoadNotification()
  }

  open(){
    promptAction.showToast({
      message:'功能暂未实现'
    })
  }

  publishDownLoadNotification(){


    if(!this.isSupport){
      //当前系统不支持进度条模板
      return
    }
    //准备进度模板参数
    let tempate={
      name:'downloadTemplate',
      data:{
        progressValue:this.progressValue,
        progressMaxValue:100

      }
    }

    let request:notify.NotificationRequest={
      id:this.notificationId,
      template:tempate,
      wantAgent:this.wantAgentInstance,
      content:{
        contentType:notify.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal:{
          title:this.filename+': '+this.state,
          text:'',
          additionalText:`${this.progressValue}%`
        }
      }
    }

    //发送通知
    notify.publish(request)
      .then(()=>{
        console.log('DownloadCard','通知发送成功')
      })
      .catch(reason=>{
        console.log('DownloadCard','通知发送失败',JSON.stringify(reason))
      })
  }


}