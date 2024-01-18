
import relationalStore from '@ohos.data.relationalStore';
import Tasks from '../viewmodel/Tasks';

class TaskModel{

  private rdbStore:relationalStore.RdbStore
  private tableName:string='TASKS'

  /**
   * 初始化任务表
   */
  initTaskDB(context){
    //rdb配置
    const config ={
      name:'application.db',
      securityLevel:relationalStore.SecurityLevel.S1
    }
    //初始化sql语句
    const sql=`CREATE TABLE IF NOT EXISTS TASKS(
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                NAME TEXT NOT NULL,
                FINISHED bit
                )`
    //获取rdb
    relationalStore.getRdbStore(context,config,(err,rdbStore)=>{
      if(err){
        console.log('testTag','获取rdbStore失败！')
        return
      }
      rdbStore.executeSql(sql)
      console.log('testTag','创建TASKS表成功！')

      this.rdbStore=rdbStore
    })
  }

  /**
   * 查询任务列表
   */
  async  getTaskList(){
    let predicates =new relationalStore.RdbPredicates(this.tableName)
    let result = await this.rdbStore.query(predicates,['ID','NAME','FINISHED'])
    let tasks:Tasks[]=[]
    //解析结果
    while (!result.isAtLastRow) {
      let id = result.getLong(result.getColumnIndex('ID'))
      let name = result.getString(result.getColumnIndex('NAME'))
      let finished = result.getLong(result.getColumnIndex('FINISHED'))
      tasks.push({id,name,finished:!!finished})
    }
    console.log('testTag','查询到数据：'+JSON.stringify(tasks))
    return tasks
  }

  /**
   * 添加一个新的任务
   * @param name 任务名称
   * @return 任务id
   */
  addTask(name:string):Promise<number>{
    return this.rdbStore.insert(this.tableName,{name,finished:false})
  }

  /**
   * 根据id更新任务状态
   * @param id 任务id
   * @param finished 任务是否完成
   */
  updateTaskStatus(id:number,finished:boolean){
    //需要更新的数据
    let data ={finished:finished}
    //更新条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('id',id)
    //更新操作
    return this.rdbStore.update(data,predicates)
  }

  /**
   * 根据id删除任务
   * @param id 任务id
   */
  deleteTaskById(id:number){
    //删除条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('id',id)
    //删除操作
    return this.rdbStore.delete(predicates)
  }


}

let taskModel =new TaskModel();

export default taskModel as TaskModel