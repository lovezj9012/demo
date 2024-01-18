import preferences from '@ohos.data.preferences';

class PreferenceUtil{

  preMap:Map<string,preferences.Preferences>=new Map()

  //异步写法
  /*loadPreference(context,name:string){
    preferences.getPreferences(context,name)
      .then(pre=>{
        this.preMap.set(name,pre)
        console.log('testTag',`加载Preference[${name}]成功`)
      })
      .catch(reason=>{
        console.log('testTag',`加载Preference[${name}]失败`,JSON.stringify(reason))
      })
  }*/

  //同步写法
  async loadPreference(context,name:string){

    try {
      let pref = await preferences.getPreferences(context,name)
      this.preMap.set(name,pref)
      console.log('testTag',`加载Preference[${name}]成功`)
    }catch (e){
      console.log('testTag',`加载Preference[${name}]失败`,JSON.stringify(e))
    }

  }

  async putPreferenceValue(name:string,key:string,value:preferences.ValueType){
    if(this.preMap.has(name)){
      console.log('testTag',`加载Preference[${name}]尚未初始化`)
      return
    }
    try {
      let pref = this.preMap.get(name)
      //保存数据
      await pref.put(key, value)
      //刷入磁盘
      pref.flush()
      console.log('testTag', `保存Preference[${name}.${key}=${value}]成功`)
    } catch (e) {
      console.log('testTag',`保存Preference[${name}.${key}=${value}]失败`,JSON.stringify(e))
    }
  }

  async getPreferenceValue(name:string,key:string,defaultValue:preferences.ValueType){
    if(this.preMap.has(name)){
      console.log('testTag',`加载Preference[${name}]尚未初始化`)
      return
    }

    try {
      let pref = this.preMap.get(name)
      let value = await pref.get(key,defaultValue)
      console.log('testTag', `读取Preference[${name}.${key}=${value}]成功`)
      return value
    }catch (e){
      console.log('testTag', `读取Preference[${name}.${key}]失败`,JSON.stringify(e))
    }

  }

  async deletePreference(name:string,key:string){
    if(this.preMap.has(name)){
      console.log('testTag',`加载Preference[${name}]尚未初始化`)
      return
    }

    try {
      let pref = this.preMap.get(key)
      await pref.delete(key)
      console.log('testTag', `删除Preference[${name}.${key}]成功`)
    } catch (e) {
      console.log('testTag', `删除Preference[${name}.${key}]失败`)
    }

  }


}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil