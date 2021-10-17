--[[
العاب سورس YxY
--]]
local function games(msg,MsgText)
if msg.type ~= "pv" then
if MsgText[1] == "تفعيل" and MsgText[2] == "الالعاب" or MsgText[2] == "اللعبه" or MsgText[2] == "اللعبة" then
if not msg.Admin then return "- هذا الامر يخص ( الادمن,المدير,المالك,المطور) بس" end
if not redis:get(boss..'lock_geams'..msg.chat_id_) then 
return "⇠ اهلين عزيزي "..msg.TheRankCmd.."\n⇠ الالعاب مفتوح من قبل\n" 
else 
redis:del(boss..'lock_geams'..msg.chat_id_) 
return "⇠ اهلين عزيزي "..msg.TheRankCmd.."\n⇠ ابشر فتحت الالعاب \n" 
end 
end
if MsgText[1] == "تعطيل" and MsgText[2] == "الالعاب" or MsgText[2] == "اللعبه" or MsgText[2] == "اللعبة" then
if not msg.Admin then return "- هذا الامر يخص ( الادمن,المدير,المالك,المطور) بس" end
if redis:get(boss..'lock_geams'..msg.chat_id_) then 
return "⇠ اهلين عزيزي "..msg.TheRankCmd.."\n⇠ الالعاب معطله من قبل\n" 
else
redis:set(boss..'lock_geams'..msg.chat_id_,true)  
return "⇠ اهلين عزيزي "..msg.TheRankCmd.."\n⇠ ابشر تم تعطيل الالعاب\n" 
end   
end
if MsgText[1] == "اضف رسائل" and msg.reply_to_message_id_ == 0 then       
if not msg.Creator then 
return "- هذا الامر يخص (المالك,المطور) بس" 
end 
local ID_USER = MsgText[2]
redis:set(boss..'SET:ID:USER'..msg.chat_id_,ID_USER)  
redis:setex(boss.."SETEX:MSG"..msg.chat_id_..""..msg.sender_user_id_,500,true)  
sendMsg(msg.chat_id_,msg.id_,'*⇜ ارسل لي عدد الرسائل اللي تبيها*')
end
if MsgText[1] == "اضف مجوهرات" and msg.reply_to_message_id_ == 0 then       
if not msg.Creator then 
return "- هذا الامر يخص (المالك,المطور) بس" 
end 
local ID_USER = MsgText[2]
redis:set(boss..'SET:ID:USER:NUM'..msg.chat_id_,ID_USER)  
redis:setex(boss.."SETEX:NUM"..msg.chat_id_..""..msg.sender_user_id_,500,true)  
sendMsg(msg.chat_id_,msg.id_,'*⇠ ارسل لي عدد المجوهرات اللي تبيها*')
end
if not redis:get(boss..'lock_geams'..msg.chat_id_) and msg.GroupActive then
if MsgText[1] == 'اسئله' or MsgText[1] == 'اسئلة' or MsgText[1] == ' ' then   
redis:set(boss.."GAME:S"..msg.chat_id_,true) 
t1 = [[
ماهو اطول نهر في العالم 
1- النيل  
2- الفرات 
3- نهر الكونغو


ارسل الجواب الصح بس
]]
t2 = [[
ماعدد عظام الوجه?
1- 15
2- 13
3- 14 

ارسل الجواب الصح بس
]]
t3 =[[
كراسي بيضاء وجدران ورديه اذا اغلقته اصبح ظلام  فمن اكون?

1- الفم 
2- الاذن
3- الثلاجه


ارسل الجواب الصح بس
]]
t4 =[[
كم جزء تحتوي مسلسل وادي الذئاب?

1- 7
2- 15
3- 11


ارسل الجواب الصح بس
]]
t5 =[[
كم جزء يحتوي القران الكريم?

1- 60
2- 70
3- 30 


ارسل الجواب الصح بس
]]
t6 =[[
من هوه اغنى رئيس في العالم??

1- ترامب
2- اوباما
3- بوتين  


ارسل الجواب الصح بس
]]

t7 =[[
من هوه مؤسس شركه ابل العالميه 

1-لاري بايج 
2- بيا غايتز
3- ستيف جوبر


ارسل الجواب الصح بس
]]
t8 =[[
ماهي عاصمه فرنسا?

1- باريس 
2- لوين 
3- موسكو 


ارسل الجواب الصح بس
]]
t9 =[[
ماعدد دول العربيه التي توجد في افريقيا 

1- 10 
2- 17
3- 9

ارسل الجواب الصح بس
]]
t11 =[[
ماهو الحيوان الذي يحمل 50 فوق وزنه ?
1-الفيل
2- النمل  
3- الثور


ارسل الجواب الصح بس
]]
t12 =[[
ماذا يوجد بيني وبينك؟  
1- الضل
2- الاخلاق
3-حرف الواو  


ارسل الجواب الصح بس
]]
t13 =[[
ماهو الشيء النبات ينبت للانسان بلا بذر؟
1-الاضافر 
2- الاسنان
3- الشعر


ارسل الجواب الصح بس
]]
t14 =[[
م̷ـــِْن هو اول الرسول الى الارض؟
1- ادم
2- نوح
3-ابراهيم 


ارسل الجواب الصح بس
]]
t15 =[[
ما هو الشّيء الذي يستطيع المشي بدون أرجل والبكاء بدون أعين؟
1- سحاب
2- بئر
3- نهر


ارسل الجواب الصح بس
]]
t16 =[[
ما الشيء الذي نمتلكه , لكنّ غيرنا يستعمله أكثر منّا؟
1- العمر
2- ساعه
3- الاسم


ارسل الجواب الصح بس
]]
t17 =[[
اصفر اللون سارق عقول اهل الكون وحارمهم لذيذ النوم
1- نحاس
2- الماس
3- ذهب


ارسل الجواب الصح بس
]]
t18 =[[
في الليل ثلاثة لكنه في النهار واحده فما هو
 1- حرف الباء
 2- حرف الام 
3- حرف الراء


ارسل الجواب الصح بس
]]
t19 =[[
على قدر اصل العزم تأتي?
1- العزائم 
2- المكارم
3- المبائب


ارسل الجواب الصح بس
]]

t20 =[[
ماهي جمع كلمه انسه ?
1- سيدات
2- انسات 
3- قوانص


ارسل الجواب الصح بس
]]
t21 =[[
اله اتسعلمت قديما في الحروب?
1- الصاروخ
2- المسدس
3- المنجنيق 


ارسل الجواب الصح بس
]]
t22 =[[
تقع لبنان في قاره?
1- افريقيا 
2- اسيا  
3- امركيا الشماليه


ارسل الجواب الصح بس
]]

t23 =[[
1- ماهو الحيوان الذي يلقب بملك الغابه?
1-الفيل
2- الاسد 
3- النمر


ارسل الجواب الصح بس
]]
t24 =[[
كم صفرا للمليون ?
1- 4 
2- 3
3-6

ارسل الجواب الصح بس
]]
t25 =[[
ما اسم صغير الحصان?
1- مهر  
2- جرو
3- عجل


ارسل الجواب الصح بس
]]
t26 =[[
ما الحيوان الذي ينام واحدى عينه مفتوحه?

1- القرش
2- الدلفين 
3- الثعلب


ارسل الجواب الصح بس
]]
t27 =[[
ماهي القاره التي تلقب بالقاره العجوز?

1- امريكا الشماليه 
2- امريكا الجنوبيه
3- افريقيا 


ارسل الجواب الصح بس
]]
t28 =[[
ما اسم المعدن الموجود فيي الحاله السائله 

1- النحاس 
2- الحديد
3- الزئبق  


ارسل الجواب الصح بس
]]
t29 =[[
ماهي عاصمه انجلترا?
1- لندن  
2- لفرسول
3- تركيا


ارسل الجواب الصح بس
]]
t30 =[[
ماهو الشئ الذي برأسه سبع فتحات

1- الهاتف
2- التلفاز
3- الانسان 


ارسل الجواب الصح بس
]]
t31 =[[
ماهي عاصمه اليابان ?
1- بانكول
2- نيو دلهي
3- طوكيو 


ارسل الجواب الصح بس
]]
t32 =[[
من هي زوجه الرسول الاكبر منه سنآ?

1- حفضه
2- زينب 
3- خديجه 


ارسل الجواب الصح بس
]]
TAHA = {t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t1,t2,t3,t4,t5,t6,t7,t8,t9,t11,t12,t13,t14,t15}
local SENDTEXT = TAHA[math.random(#TAHA)]
if SENDTEXT:find('النيل') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'النيل') 
elseif SENDTEXT:find('14') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'14') 
elseif SENDTEXT:find('الفم') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الفم') 
elseif SENDTEXT:find('11') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'11') 
elseif SENDTEXT:find('30') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'30') 
elseif SENDTEXT:find('بوتين') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'بوتين') 
elseif SENDTEXT:find('ستيف جوبر') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'ستيف جوبر') 
elseif SENDTEXT:find('باريس') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'باريس') 
elseif SENDTEXT:find('10') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'10') 
elseif SENDTEXT:find('النمل') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'النمل') 
elseif SENDTEXT:find('حرف الواو') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'حرف الواو') 
elseif SENDTEXT:find('الشعر') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الشعر') 
elseif SENDTEXT:find('ابراهيم') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'ابراهيم') 
elseif SENDTEXT:find('سحاب') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'سحاب') 
elseif SENDTEXT:find('الاسم') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الاسم') 
elseif SENDTEXT:find('ذهب') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'ذهب') 
elseif SENDTEXT:find('حرف الام') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'حرف الام') 
elseif SENDTEXT:find('العزائم') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'العزائم') 
elseif SENDTEXT:find('انسات') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'انسات') 
elseif SENDTEXT:find('المنجنيق') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'المنجنيق') 
elseif SENDTEXT:find('اسيا') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'اسيا') 
elseif SENDTEXT:find('الاسد') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الاسد') 
elseif SENDTEXT:find('6') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'6') 
elseif SENDTEXT:find('مهر') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مهر') 
elseif SENDTEXT:find('الدلفين') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الدلفين') 
elseif SENDTEXT:find('اوروبا') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'اوروبا') 
elseif SENDTEXT:find('الزئبق') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الزئبق') 
elseif SENDTEXT:find('لندن') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'لندن') 
elseif SENDTEXT:find('الانسان') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'الانسان') 
elseif SENDTEXT:find('طوكيو') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'طوكيو') 
elseif SENDTEXT:find('خديجه') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'خديجه') 
end
sendMsg(msg.chat_id_,msg.id_,SENDTEXT)     
return false  
end

if MsgText[1] == 'المختلف' then
katu = {'😸','☠','🐼','🐇','🌑','🌚','⭐️','✨','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍🔧','👩‍🍳','🧚‍♀','🧜‍♂','🧝‍♂','🙍‍♂','🧖‍♂','👬','👨‍👨‍👧','🕓','🕤','⌛️','📅',
};
name = katu[math.random(#katu)]
redis:set(boss..':Set_alii:'..msg.chat_id_,name)
name = string.gsub(name,'😸','😹😹😹😹😹😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠','💀💀💀💀💀💀💀☠💀💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻👻👻👻👻🐼👻👻👻👻👻')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟')
name = string.gsub(name,'✨','💫💫💫💫💫✨💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃☃☃☃☃☃⛄️☃☃☃☃')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👩‍💻👩‍💻👩‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'👩‍🍳','👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀','🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂')
name = string.gsub(name,'🧜‍♂','🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♂🧜‍♀🧜‍♀🧜‍♀')
name = string.gsub(name,'🧝‍♂','🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀')
name = string.gsub(name,'🙍‍♂','🙎‍♂🙎‍♂🙎‍♂🙎‍♂🙎‍♂🙍‍♂🙎‍♂🙎‍♂🙎‍♂')
name = string.gsub(name,'🧖‍♂','🧖‍♀🧖‍♀🧖‍♀🧖‍♀🧖‍♀🧖‍♂🧖‍♀🧖‍♀🧖‍♀🧖‍♀')
name = string.gsub(name,'👬','👭👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕓','🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆📆📆📆📆📆📅📆📆')
return '  اول واحد يطلع المختلف  ⇠ (* '..name..' * ) ' 
end

if MsgText[1] == 'امثله' then
katu = {
'سبقني','الصقر','الفصيح','عون','الدله','يعرفك','السواهي','بعين','الخيل','عدوك','النخله','علقو','الطير','محبته','حجته','القط','قسمه','الفوت','الزمان','مخابر',
};
name = katu[math.random(#katu)]
redis:set(boss..':Set_Amthlh:'..msg.chat_id_,name)
name = string.gsub(name,'وسبقني','ضربني وبكاء .... وشتكى')
name = string.gsub(name,'الصقر','الي ما يعرف .... يشويه')
name = string.gsub(name,'يعرفك','الي ما .... ما يثمنك')
name = string.gsub(name,'عون','جبتك .... صرتلي فرعون')
name = string.gsub(name,'الدله','اقلب .... على فمها تطلع البنت على امها')
name = string.gsub(name,'النخله','الطول طول .... والعقل عقل الصخلة')
name = string.gsub(name,'السواهي','تحت .... دواهي')
name = string.gsub(name,'بعين','القرد .... امه غزال')
name = string.gsub(name,'عدوك','خاف من .... مره ومن صديقك الف مره')
name = string.gsub(name,'قبل','الجار .... الدار')
name = string.gsub(name,'الفصيح','الديك .... من البيضه يصيح')
name = string.gsub(name,'علقو','المنحوس منحوس لو .... على راسه فانوس')
name = string.gsub(name,'محبته','الي تتغير ... تتغير مخدته')
name = string.gsub(name,'حجته','الغايب .... معه')
name = string.gsub(name,'القط','اذا غاب .... اللعب يا فار')
name = string.gsub(name,'قسمه','الجيزة .... ونصيب')
name = string.gsub(name,'الفوت','اذا فات .... ما ينفع الصوت')
name = string.gsub(name,'الزمان','اذا ما طاعك .... طيعه')
name = string.gsub(name,'الطير','اذا كان فيه .... ما رماه الطير')
name = string.gsub(name,'مخابر','الرجال .... مو مناظر')
return 'اكمل المثل التالي (* '..name..' *)'
end

if MsgText[1] == 'انقليزي' or MsgText[1] == 'الانقليزي' then
  katu = {
  'افتح','باب','الافضل','جدار','طيران','ورده','جيد','سيء','اريد','غريب','خطير','يهتم','حفظ','تحرك','ربما','ثقة','حقيقه','صندوق','يد','شجاع','هادئ','حذر','مرح','ذكي','جبان','مجنون','عاطفي','ودود','مضحك','كريم','صادق','غير صبور','غير مهذب','حنون','كسول','حقير','مريض',
  };
  name = katu[math.random(#katu)]
  redis:set(boss..':Set_ang:'..msg.chat_id_,name)
  name = string.gsub(name,'افتح','Open')
  name = string.gsub(name,'باب','Door')
  name = string.gsub(name,'الافضل','Best')
  name = string.gsub(name,'جدار','Wall')
  name = string.gsub(name,'طيران','Fly')
  name = string.gsub(name,'ورده','Flower')
  name = string.gsub(name,'جيد','Good')
  name = string.gsub(name,'سيء','Bay')
  name = string.gsub(name,'اريد','Want')
  name = string.gsub(name,'غريب','Stranger')
  name = string.gsub(name,'خطير','Dangerous')
  name = string.gsub(name,'يهتم','Care')
  name = string.gsub(name,'حفظ','Save')
  name = string.gsub(name,'تحرك','Move')
  name = string.gsub(name,'ربما','Maybe')
  name = string.gsub(name,'ثقة','Trust')
  name = string.gsub(name,'حقيقه','Truth')
  name = string.gsub(name,'صندوق','Box')
  name = string.gsub(name,'يد','Hand')
  name = string.gsub(name,'شجاع','Brave')
  name = string.gsub(name,'هادئ','Calm')
  name = string.gsub(name,'حذر','Cautious')
  name = string.gsub(name,'مرح','Cheerful')
  name = string.gsub(name,'ذكي','Clever')
  name = string.gsub(name,'جبان','Cowardly')
  name = string.gsub(name,'مجنون','Crazy')
  name = string.gsub(name,'عاطفي','Emotional')
  name = string.gsub(name,'ودود','Friendly')
  name = string.gsub(name,'مضحك','Funny')
  name = string.gsub(name,'كريم','Generous')
  name = string.gsub(name,'صادق','Honest')
  name = string.gsub(name,'غير صبور','Impatient')
  name = string.gsub(name,'غير مهذب','Impolite')
  name = string.gsub(name,'حنون','Kind')
  name = string.gsub(name,'كسول','Lazy')
  name = string.gsub(name,'حقير','Mean')
  name = string.gsub(name,'مريض','Patient')
  return 'اجب على معنى الكلمة (* '..name..' *)'
  end
  
if MsgText[1] == 'حزوره' then
katu = {'امي','انا','المخده','الهواء','الهواء','القمر','المقفل','النهر','الغيم','اسمك','حرف الام','الضابط','الدائره','الجمعة','ابل','الصمت','السلحفات','كم الساعه','شجره العائله','ضفدع','خليه النحل','الصوت','الجوع','الكتاب','البيض','الاسفنجه','البرتقال','الكفن','الساعه','الطاولة','البصل','الوقت','النار','الثلج','العمر','المسمار','الحفره','المشط','الجوال','الجرس','المراه','الغداء','الفيل','الصدى','الهواء','عقرب الساعه'};
name = katu[math.random(#katu)]
redis:set(boss..':Set_Hzorh:'..msg.chat_id_,name)
name = string.gsub(name,'امي','اخت خالك ومهي خالتك منهي؟')
name = string.gsub(name,'انا','ورع امك وورع ابوك ومهي اختك ولاخوك منهو؟')
name = string.gsub(name,'المخده','انا خفيفه وانا لطيفه اقعد بحضن الخليفه أزيح الهموم  واخلي الحييب نايم من انا؟')
name = string.gsub(name,'الهواء','ماهو الشيء الذي يسير امامك ولا تراه؟')
name = string.gsub(name,'القمر','ماهو الشيء الذي يحيا اول الشهر ويموت في اخره؟')
name = string.gsub(name,'المقفل','وش الباب الي ما يمديك تفتحه؟')
name = string.gsub(name,'النهر','ماهو الشي الذي يجري ولا يمشي؟')
name = string.gsub(name,'الغيم','ماهو الشي الذي يمشي بلا رجلين ويبكي بلا عيون؟')
name = string.gsub(name,'اسمك','ماهو الشيء الذي لك ويستخدمه الناس من دون اذنك؟')
name = string.gsub(name,'حرف الام','ماهو الشيء الذي تراه في الليل ثلاث مرات والنهار مره واحده؟')
name = string.gsub(name,'الضابط','رجوله في الارض وراسه فوق النجوم؟')
name = string.gsub(name,'الدائره','ماهو الشيء الذي ليس له بدايه وليس له نهاية؟')
name = string.gsub(name,'الجمعة','لدينا ثلاث أعياد ليس عيد الفطر وليس عيد الاضحى فما هو؟')
name = string.gsub(name,'ابل','تفاحة ماكول نصها وش هي؟')
name = string.gsub(name,'الصمت','ماهي الكلمه الذي يبطل معناها اذا نطقت بها؟ ')
name = string.gsub(name,'السلحفاة','ماهو الذي لحمهه من الداخل وعضمهه من الخارج؟ ')
name = string.gsub(name,'كم الساعه','ماهوه السؤال الذي تختلف اجابته دائماً؟')
name = string.gsub(name,'شجره العائله','ما اسم الشجره التي ليس لها ضل ولا لها ثمار؟ ')
name = string.gsub(name,'الضفدع','ماهو الحيوان الذي لسانه طويل وجسمه صغير؟')
name = string.gsub(name,'خليه النحل','ماهو الشيء الذي يتسع مئاات الالوف ولا يتسع طير منتوف؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا ب الاذنين؟')
name = string.gsub(name,'الجوع','ماهو الشيء الذي يقرصك ولا تراه؟')
name = string.gsub(name,'الكتاب','له اوراق وما هو بنبات، له جلد وماهو بحيوان . وعلم وماهو ب انسان من هو؟')
name = string.gsub(name,'البيض','ماهو الشي الذي اسمه على لونه؟')
name = string.gsub(name,'الاسفنجه','كلي ثقوب ومع ذالك احفظ الماء فمن انا؟ ')
name = string.gsub(name,'البرتقال','ماهو الشيء نرميه بعد العصر؟')
name = string.gsub(name,'الكفن','ماهو الشيء لاتحب ان تلبسة وان لبستة لاترة؟')
name = string.gsub(name,'الساعه','ماهو الشيء الذي يمشي ويقف وليس له ارجل؟')
name = string.gsub(name,'الطاولة','اننا اربعة اخوه ولنا راس واحد فمن نحن؟')
name = string.gsub(name,'البصل','شيء تذبحه وتبكي عليه؟')
name = string.gsub(name,'الوقت','يذهب ولا يرجع؟')
name = string.gsub(name,'النار','شيء ياكل ولايشبع وان شرب الماء مات؟')
name = string.gsub(name,'الثلج','شيء مصنوع من الماء وان عاش في الماء يموت؟')
name = string.gsub(name,'العمر','ماهو الشيء الذي كلما زاد نقص؟')
name = string.gsub(name,'المسمار','ماهو الشيء الذي لا يمشي الا ب الضرب؟')
name = string.gsub(name,'الحفره','ماهو الشيء الذي كلما اخذنا منهه زاد وكبر؟')
name = string.gsub(name,'المشط','له اسنان ولا يعض ماهو؟ ')
name = string.gsub(name,'الجوال','يسمع بلا اذن ويحكي بلا لسان فما هو؟')
name = string.gsub(name,'الجرس','ماهو الشيء الذي اذا لمسته صاح؟')
name = string.gsub(name,'المراه','ارى كل شيء من دون عيون فمن اكون؟')
name = string.gsub(name,'الغداء','ماهو الشيء الذي لايؤكل في الليل؟ ')
name = string.gsub(name,'الفيل','من هوه الحيوان الذي يحك اذنه في انفه؟')
name = string.gsub(name,'الصدى','ماهو الشيء الذي يتكلم جميع اللغات؟ ')
name = string.gsub(name,'الهواء','شيء بيني وبينك لا تراه عينك ولا عيني فما هوه؟')
name = string.gsub(name,'عقرب الساعه','هناك عقرب لا يلدغ ولا يخاف منه الاطفال فما هوه؟')
return '  اول واحد يحلها  ⇠ (* '..name..' *) ' 
end

if MsgText[1] == 'رياضيات' then
katu = {
'95','399','144','119','-2','9','8','55','511','114','877','153','509','932','211','7','67','143','515','515',
};
name = katu[math.random(#katu)]
redis:set(boss..':Set_ria:'..msg.chat_id_,name)
name = string.gsub(name,'95','12+83')
name = string.gsub(name,'399','491-92')
name = string.gsub(name,'9','3+6')
name = string.gsub(name,'119','37+82')
name = string.gsub(name,'-2','5+18-25')
name = string.gsub(name,'877','300+827-250')
name = string.gsub(name,'8','2+7-1')
name = string.gsub(name,'55','36+19')
name = string.gsub(name,'114','6+8+100')
name = string.gsub(name,'143','62+72')
name = string.gsub(name,'144','62+82')
name = string.gsub(name,'153','72+81')
name = string.gsub(name,'932','566+566-200')
name = string.gsub(name,'211','139+72')
name = string.gsub(name,'7','6+7-6')
name = string.gsub(name,'67','55+12')
name = string.gsub(name,'515','514+1')
name = string.gsub(name,'515','100+415')
name = string.gsub(name,'511','500+11')
name = string.gsub(name,'509','500+9')
return 'اجـب على المسئله الحسابيه التالية ↤ (* '..name..' *)'
end

if MsgText[1] == 'محيبس' then
Num = math.random(1,6)
redis:set(boss.."GAMES"..msg.chat_id_,Num) 
TEST = [[
*➀       ➁     ➂      ➃      ➄     ➅
↓      ↓     ↓      ↓     ↓     ↓
👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊


 ⇠اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
⇠ الفائز يحصل على ( 3 ) من المجوهرات *
]]
sendMsg(msg.chat_id_,msg.id_,TEST)   
redis:setex(boss.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
if MsgText[1] == 'خمن' or MsgText[1] == 'تخمين' then   
Num = math.random(1,20)
redis:set(boss.."GAMES:NUM"..msg.chat_id_,Num) 
TEST = '*\n⇠ هلا فيك بلعبة التخمين :\n━━━━━━━━━━\n'..' ⇠ عندك ( 3 ) محاولات بس فكر قبل ماترسل تخمينك \n\n'..' ⇠ راح يتم تخمين عدد بين ال (1 و 20) اذا تحس انك تقدر تفوز جرب واللعب الحين! \n𓍦*'
sendMsg(msg.chat_id_,msg.id_,TEST)
redis:setex(boss.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
if (MsgText[1] == 'اسرع' or MsgText[1] == 'الاسرع') then
local NUM = math.random(10,1000)
redis:set(boss..':NUM_SET:'..msg.chat_id_,(NUM * 3))
local Smiles = {'🍏','🍎','🍐',NUM,NUM,NUM,NUM,NUM,'🍊','🍋','🍌','🍉',NUM,NUM,NUM,NUM,NUM,'🍇','🍓','🍈','🍒',NUM,NUM,NUM,NUM,NUM,'🍑','🍍','🥥','🥝','🍅',NUM,NUM,NUM,NUM,NUM,'🍆','🥑','🥦','🥒',NUM,NUM,NUM,NUM,NUM,'🌶','🌽','🥕','🥔','🍠','🥐','🍞',NUM,NUM,NUM,NUM,NUM,'🥖','🥨','🧀','🥚','🍳','🥞','🥓',NUM,NUM,NUM,NUM,NUM,'🥩','🍗','🍖','🌭','🍔','🍟',NUM,NUM,NUM,NUM,NUM,'🍕','🥪','🥙','🍼','☕️','🍵',NUM,NUM,NUM,NUM,NUM,'🥤','🍶','🍺','🍻',NUM,NUM,NUM,NUM,NUM,'🏀','⚽️','🏈','⚾️','🎾','🏐',NUM,NUM,NUM,NUM,NUM,'🏉','🎱','🏓','🏸','🥅','🎰','🎮',NUM,NUM,NUM,NUM,NUM,'🎳','🎯','🎲','🎻','🎸','🎺','🥁','🎹',NUM,NUM,NUM,NUM,NUM,'🎼','🎧','🎤','🎬','🎨','🎭',NUM,NUM,NUM,NUM,NUM,'🎪','🎟','🎫','🎗','🏵','🎖','🏆','🥌','🛷','🚕','🚗','🚙','🚌',NUM,NUM,NUM,NUM,NUM,'🚎','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔','🛡','🔮','🌡','💣','📌',NUM,NUM,NUM,NUM,NUM,'📍','📓','📗','📂','📅','📪','📫','📬',NUM,NUM,NUM,NUM,NUM,'📭','⏰','📺','🎚','☎️',NUM,NUM,NUM,NUM,NUM,'📡'}
Emoji = Smiles[math.random(#Smiles)]
redis:set(boss..':Set_Smile:'..msg.chat_id_,Emoji)
if tonumber(redis:get(boss..':Set_Smile:'..msg.chat_id_)) == tonumber(redis:get(boss..':NUM_SET:'..msg.chat_id_)) then
return '◀️┇اول من يكتب هذه العدد يفوز ؛  ››`'..(redis:get(boss..':Set_Smile:'..msg.chat_id_))..'`'
else
return 'اسرع واحد يرسل السمايل يفوز  ~    `'..(redis:get(boss..':Set_Smile:'..msg.chat_id_))..'`'
end
end
if MsgText[1] == 'تفكيك' then
  katu = {'ا ح ب ك','ذ ئ ب','ب ع ي ر','ط ي ر','و ر د ه','ج م ي ل ','ح ل و','ب ط ر ي ق','ط م ا ط م','م و ز','س ي ا ر ة','ت ح ر ي ك','ف ل و س','ب و ت','ث ق ة','ح ل ز و ن','م ك ي ف','م ر و ح ه'
  };
  name = katu[math.random(#katu)]
  redis:set(boss..':Set_fkk:'..msg.chat_id_,name)
  name = string.gsub(name,'ا ح ب ك','احبك')
  name = string.gsub(name,'ا ك ر ه ك','اكرهك')
  name = string.gsub(name,'ذ ئ ب','ذئب')
  name = string.gsub(name,'ب ع ي ر','بعير')
  name = string.gsub(name,'ط ي ر','طير')
  name = string.gsub(name,'و ر د ه','ورده')
  name = string.gsub(name,'ج م ي ل','جميل')
  name = string.gsub(name,'ح ل و','حلو')
  name = string.gsub(name,'ب ط ر ي ق','بطريق')
  name = string.gsub(name,'ط م ا ط م','طماطم')
  name = string.gsub(name,'م و ز','موز')
  name = string.gsub(name,'س ي ا ر ة','سيارة')
  name = string.gsub(name,'ت ح ر ي ك','تحريك')
  name = string.gsub(name,'ف ل و س','فلوس')
  name = string.gsub(name,'ب و ت','بوت')
  name = string.gsub(name,'ث ق ة','ثقة')
  name = string.gsub(name,'ح ل ز و ن','حلزون')
  name = string.gsub(name,'م ك ي ف','مكيف')
  name = string.gsub(name,'م ر و ح ه','مروحه')
  return 'اسرع واحد يفكك (* '..name..' *)'
  end
  if MsgText[1] == 'تركيب' then
  katu = {'احبك','ذئب','بعير','طير','ورده','جميل ','حلو','بطريق','طماطم','موز','سيارة','تحريك','فلوس','بوت','ثقة','حلزون','مكيف','مروحه'
  };
  name = katu[math.random(#katu)]
  redis:set(boss..':Set_trkib:'..msg.chat_id_,name)
  name = string.gsub(name,'احبك','ا ح ب ك')
  name = string.gsub(name,'ذئب','ذ ئ ب')
  name = string.gsub(name,'بعير','ب ع ي ر')
  name = string.gsub(name,'طير','ط ي ر')
  name = string.gsub(name,'ورده','و ر د ه')
  name = string.gsub(name,'جميل','ج م ي ل')
  name = string.gsub(name,'حلو','ح ل و')
  name = string.gsub(name,'بطريق','ب ط ر ي ق')
  name = string.gsub(name,'طماطم','ط م ا ط م')
  name = string.gsub(name,'موز','م و ز')
  name = string.gsub(name,'سيارة','س ي ا ر ة')
  name = string.gsub(name,'تحريك','ت ح ر ي ك')
  name = string.gsub(name,'فلوس','ف ل و س')
  name = string.gsub(name,'بوت','ب و ت')
  name = string.gsub(name,'ثقة','ث ق ة')
  name = string.gsub(name,'حلزون','ح ل ز و ن')
  name = string.gsub(name,'مكيف','م ك ي ف')
  name = string.gsub(name,'مروحه','م ر و ح ه')
  return 'اسرع واحد يركب (* '..name..' *)'
  end
  
if MsgText[1] == 'ترتيب' then
katu = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = katu[math.random(#katu)]
redis:set(boss..':Set_Arg:'..msg.chat_id_,name)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ي ف ا')
name = string.gsub(name,'بزونه','ز و ب ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ث ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ا ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
return '  اسرع واحد يرتبها (* '..name..' *) ' 
end
if MsgText[1] == 'معاني' then
katu = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديج','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = katu[math.random(#katu)]
redis:set(boss..':Set_Name_Meant:'..msg.chat_id_,name)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','🐬')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐭')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
return ' اول من يكتب معنى السمايل يفوز ( '..name..' )'
end
if MsgText[1] == 'كت تويت' or MsgText[1] == 'تويت' or MsgText[1] == 'كت' then
katu = {' دحوو1م ',' دحوو2م ',' دحوو3م ',' دحوو4م ',' دحوو5م ',' دحوو6م ',' دحوو7م ',' دحوو8م ',' دحوو9م ',' دحوو10م ',' دحوو11م ',' دحوو12م ',' دحوو13م ',' دحوو14م ',' دحوو15م ',' دحوو16م ',' دحوو17م ',' دحوو18م ',' دحوو19م ',' دحوو20م ',' دحوو21م ',' دحوو22م ',' دحوو23م ',' دحوو24م ',' دحوو25م ',' دحوو26م ',' دحوو27م ',' دحوو28م ',' دحوو29م ',' دحوو30م ',' دحوو31م ',' دحوو32م ',' دحوو33م ',' دحوو34م ',' دحوو35م ',' دحوو36م ',' دحوو37م ',' دحوو38م ',' دحوو39م ',' دحوو40م ',' دحوو41م ',' دحوو42م ',' دحوو43م ',' دحوو44م ',' دحوو45م ',' دحوو46م ',' دحوو47م ',' دحوو48م ',' دحوو49م ',' دحوو50م ',' دحوو51م ',' دحوو52م ',' دحوو53م ',' دحوو54م ',' دحوو55م '}
katu = {' دحوو1م ',' دحوو2م ',' دحوو3م ',' دحوو4م ',' دحوو5م ',' دحوو6م ',' دحوو7م ',' دحوو8م ',' دحوو9م ',' دحوو10م ',' دحوو11م ',' دحوو12م ',' دحوو13م ',' دحوو14م ',' دحوو15م ',' دحوو16م ',' دحوو17م ',' دحوو18م ',' دحوو19م ',' دحوو20م ',' دحوو21م ',' دحوو22م ',' دحوو23م ',' دحوو24م ',' دحوو25م ',' دحوو26م ',' دحوو27م ',' دحوو28م ',' دحوو29م ',' دحوو30م ',' دحوو31م ',' دحوو32م ',' دحوو33م ',' دحوو34م ',' دحوو35م ',' دحوو36م ',' دحوو37م ',' دحوو38م ',' دحوو39م ',' دحوو40م ',' دحوو41م ',' دحوو42م ',' دحوو43م ',' دحوو44م ',' دحوو45م ',' دحوو46م ',' دحوو47م ',' دحوو48م ',' دحوو49م ',' دحوو50م ',' دحوو51م ',' دحوو52م ',' دحوو53م ',' دحوو54م ',' دحوو55م ',' دحوو56م ',' دحوو57م ',' دحوو58م ',' دحوو59م ',' دحوو60م ',' دحوو61م ',' دحوو62م ',' دحوو63م ',' دحوو64م ',' دحوو65م ',' دحوو66م ',' دحوو67م ',' دحوو68م ',' دحوو69م ',' دحوو70م ',' دحوو71م ',' دحوو72م ',' دحوو73م ',' دحوو74م ',' دحوو75م ',' دحوو76م ',' دحوو77م ',' دحوو78م ',' دحوو79م ',' دحوو80م ',' دحوو81م ',' دحوو82م ',' دحوو83م ',' دحوو84م ',' دحوو85م ',' دحوو86م ',' دحوو87م ',' دحوو88م ',' دحوو89م ',' دحوو90م ',' دحوو91م ',' دحوو92م ',' دحوو93م ',' دحوو94م ',' دحوو95م ',' دحوو96م ',' دحوو97م ',' دحوو98م ',' دحوو99م ',' دحوو100م ',' دحوو101م ',' دحوو102م ',' دحوو103م ',' دحوو104م ',' دحوو105م ',' دحوو106م ',' دحوو107م ',' دحوو108م ',' دحوو109م ',' دحوو110م ',' دحوو111م ',' دحوو112م ',' دحوو113م ',' دحوو114م ',' دحوو115م ',' دحوو116م ',' دحوو117م ',' دحوو118م ',' دحوو119م ',' دحوو120م ',' دحوو121م ',' دحوو121م ',' دحوو122م '}
name = katu[math.random(#katu)]
redis:set(boss..':Set_twet:'..msg.chat_id_,name)
name = string.gsub(name,' دحوو1م ',' نسبة رضاك عن الأشخاص من حولك هالفترة ؟ ')
name = string.gsub(name,' دحوو2م ',' ما السيء في هذه الحياة ؟ ')
name = string.gsub(name,' دحوو3م ','الفلوس او الحب ؟')
name = string.gsub(name,' دحوو4م ',' أجمل شيء حصل معك خلال هذا الاسبوع ؟ ')
name = string.gsub(name,' دحوو5م ',' سؤال ينرفزك ؟ ')
name = string.gsub(name,' دحوو6م ',' كم في حسابك البنكي ؟ ')
name = string.gsub(name,' دحوو7م ','اكثر ممثل تحبه ؟ ')
name = string.gsub(name,' دحوو8م ',' قد تخيلت شي في بالك وصار ؟ ')
name = string.gsub(name,' دحوو9م ',' كلمة لشخص أسعدك رغم حزنك في يومٍ من الأيام ؟ ')
name = string.gsub(name,' دحوو10م ',' شيء عندك اهم من الناس ؟ ')
name = string.gsub(name,' دحوو11م ',' اول ولد لك وش راح تسميه ؟ ')
name = string.gsub(name,' دحوو12م ',' تفضّل النقاش الطويل او تحب الاختصار ؟ ')
name = string.gsub(name,' دحوو13م ',' وش أخر شي ضيعته؟ ')
name = string.gsub(name,' دحوو14م ',' عادي تتزوج من برا القبيلة؟ ')
name = string.gsub(name,' دحوو15م ',' كم مره حبيت؟ ')
name = string.gsub(name,' دحوو16م ','تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟')
name = string.gsub(name,' دحوو17م ','لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟')
name = string.gsub(name,' دحوو18م ','قلبي على قلبك مهما صار لمين تقولها؟')
name = string.gsub(name,' دحوو19م ','اكثر المتابعين عندك باي برنامج؟')
name = string.gsub(name,' دحوو20م ','نسبة النعاس عندك حاليًا؟')
name = string.gsub(name,' دحوو21م ','نسبه الندم عندك للي وثقت فيهم ؟')
name = string.gsub(name,' دحوو22م ','وش اسم اول شخص تعرفت عليه فالتلقرام ؟')
name = string.gsub(name,' دحوو23م ','جربت شعور احد يحبك بس انت مو قادر تحبه؟')
name = string.gsub(name,' دحوو24م ','تجامل الناس ولا اللي بقلبك على لسانك؟')
name = string.gsub(name,' دحوو25م ','عمرك ضحيت باشياء لاجل شخص م يسوى ؟')
name = string.gsub(name,' دحوو26م ',' مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ')
name = string.gsub(name,' دحوو27م ','آخر غلطات عمرك؟ ')
name = string.gsub(name,' دحوو28م ','مسلسل كرتوني له ذكريات جميلة عندك؟ ')
name = string.gsub(name,' دحوو29م ','ما أكثر تطبيق تقضي وقتك عليه؟ ')
name = string.gsub(name,' دحوو30م ','أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ')
name = string.gsub(name,' دحوو31م ','قدوتك من الأجيال السابقة؟ ')
name = string.gsub(name,' دحوو32م ','أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ')
name = string.gsub(name,' دحوو33م ',' أكثر حيوان تخاف منه؟ ')
name = string.gsub(name,' دحوو34م ','ما هي طريقتك في الحصول على الراحة النفسية؟ ')
name = string.gsub(name,' دحوو35م ','إيموجي يعبّر عن مزاجك الحالي؟ ')
name = string.gsub(name,' دحوو36م ','أكثر تغيير ترغب أن تغيّره في نفسك؟ ')
name = string.gsub(name,' دحوو37م ',' أكثر شيء أسعدك اليوم؟ ')
name = string.gsub(name,' دحوو38م ',' بماذا يتعافى المرء؟ ')
name = string.gsub(name,' دحوو39م ',' ما هو أفضل حافز للشخص؟ ')
name = string.gsub(name,' دحوو40م ',' ما الذي يشغل بالك في الفترة الحالية؟')
name = string.gsub(name,' دحوو41م ',' آخر شيء ندمت عليه؟ ')
name = string.gsub(name,' دحوو42م ',' شاركنا صورة احترافية من تصويرك؟ ')
name = string.gsub(name,' دحوو43م ',' تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ')
name = string.gsub(name,' دحوو44م ',' يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ')
name = string.gsub(name,' دحوو45م ',' نصيحه تبدا ب -لا- ؟ ')
name = string.gsub(name,' دحوو46م ',' كتاب أو رواية تقرأها هذه الأيام؟ ')
name = string.gsub(name,' دحوو47م ',' فيلم عالق في ذهنك لا تنساه مِن روعته؟ ')
name = string.gsub(name,' دحوو48م ',' يوم لا يمكنك نسيانه؟ ')
name = string.gsub(name,' دحوو49م ',' شعورك الحالي في جملة؟ ')
name = string.gsub(name,' دحوو50م ',' أكثر سبب منطقي يمكن أن يجعلك تقرر الإبتعاد عن الشخص الذي تُحب؟ ')
name = string.gsub(name,' دحوو51م ',' كلمة لشخص بعيد؟ ')
name = string.gsub(name,' دحوو52م ',' صفة يطلقها عليك الشخص المفضّل؟ ')
name = string.gsub(name,' دحوو53م ',' أغنية عالقة في ذهنك هاليومين؟ ')
name = string.gsub(name,' دحوو54م ',' أكلة مستحيل أن تأكلها؟ ')
name = string.gsub(name,' دحوو55م ',' كيف قضيت نهارك؟ ')
name = string.gsub(name,' دحوو56م ',' تصرُّف ماتتحمله؟ ')
name = string.gsub(name,' دحوو57م ',' صفة يطلقها عليك من حولك بكثرة؟ ')
name = string.gsub(name,' دحوو58م ',' اسوء صفه فيك وتجاهد على تغييرها؟ ')
name = string.gsub(name,' دحوو59م ',' شاركنا أقوى بيت شِعر من تأليفك؟ ')
name = string.gsub(name,' دحوو60م ',' ماذا لو عاد معتذراً؟ ')
name = string.gsub(name,' دحوو61م ',' تقطع علاقتك بالشخص إذا عرفت إنه...؟ ')
name = string.gsub(name,' دحوو62م ',' كلام ودك يوصل للشخص المطلوب ؟ ')
name = string.gsub(name,' دحوو63م ',' ردة فعلك لمن يتجاهلك بالرد متعمد؟ ')
name = string.gsub(name,' دحوو64م ',' كم نسبة البيتوتية في شخصيتك؟ ')
name = string.gsub(name,' دحوو65م ',' متى تحس أنك فعلًا أنسان صبور جدًا ؟ ')
name = string.gsub(name,' دحوو66م ',' هل أنت من النوع الذي يواجه المشاكل أو من النوع الذي يهرب ؟ ')
name = string.gsub(name,' دحوو67م ',' أمنية كنت تتمناها وحققتها ؟ ')
name = string.gsub(name,' دحوو68م ',' تملك وسواس من شيء معين ؟ ')
name = string.gsub(name,' دحوو69م ',' عمرك انتقمت من أحد ؟! ')
name = string.gsub(name,' دحوو70م ',' متى تقرر تنسحب من أي علاقة ؟ ')
name = string.gsub(name,' دحوو71م ',' كلمتين تكررها دايم ؟! ')
name = string.gsub(name,' دحوو72م ',' افضل هديه ممكن تناسبك؟ ')
name = string.gsub(name,' دحوو73م ',' انت حزين اول شخص تتصل عليه؟ ')
name = string.gsub(name,' دحوو74م ',' موقف خلاك تحس انك مكسور ؟ ')
name = string.gsub(name,' دحوو75م ',' ماذا لو كانت مشاعر البشر مرئية ؟ ')
name = string.gsub(name,' دحوو76م ',' كم تشوف انك تستحق فرصه؟ ')
name = string.gsub(name,' دحوو77م ',' يهمك ظن الناس فيك ولا ؟ ')
name = string.gsub(name,' دحوو78م ',' اغنية عندك معاها ذكريات ')
name = string.gsub(name,' دحوو79م ',' موقف غير حياتك؟ ')
name = string.gsub(name,' دحوو80م ',' اكثر مشروب تحبه؟ ')
name = string.gsub(name,' دحوو81م ',' القصيدة اللي تأثر فيك؟ ')
name = string.gsub(name,' دحوو82م ',' متى يصبح الصديق غريب ')
name = string.gsub(name,' دحوو83م ',' هل وصلك رسالة غير متوقعة من شخص وأثرت فيك ؟ ')
name = string.gsub(name,' دحوو84م ',' وين نلقى السعاده برايك؟ ')
name = string.gsub(name,' دحوو85م ',' تاريخ ميلادك؟ ')
name = string.gsub(name,' دحوو86م ',' قهوه و لا شاي؟ ')
name = string.gsub(name,' دحوو87م ',' من محبّين الليل أو الصبح؟ ')
name = string.gsub(name,' دحوو88م ',' حيوانك المفضل؟ ')
name = string.gsub(name,' دحوو89م ',' كلمة غريبة ومعناها؟ ')
name = string.gsub(name,' دحوو90م ',' هل التعود على شخص والتحدث معه بشكل يومي يعتبر نوع من أنواع الحب؟ ')
name = string.gsub(name,' دحوو91م ',' كم تحتاج من وقت لتثق بشخص؟ ')
name = string.gsub(name,' دحوو92م ',' اشياء نفسك تجربها؟ ')
name = string.gsub(name,' دحوو93م ',' يومك ضاع على؟ ')
name = string.gsub(name,' دحوو94م ',' كل شيء يهون الا ؟ ')
name = string.gsub(name,' دحوو95م ',' اسم ماتحبه ؟ ')
name = string.gsub(name,' دحوو96م ',' وقفة إحترام للي إخترع ؟ ')
name = string.gsub(name,' دحوو97م ',' أقدم شيء محتفظ فيه من صغرك؟ ')
name = string.gsub(name,' دحوو98م ',' كلمات ماتستغني عنها بسوالفك؟ ')
name = string.gsub(name,' دحوو99م ',' وش الحب بنظرك؟ ')
name = string.gsub(name,' دحوو100م ',' حب التملك في شخصِيـتك ولا ؟ ')
name = string.gsub(name,' دحوو101م ',' تخطط للمستقبل ولا ؟ ')
name = string.gsub(name,' دحوو102م ',' موقف محرج ماتنساه ؟ ')
name = string.gsub(name,' دحوو103م ',' من طلاسم لهجتكم ؟ ')
name = string.gsub(name,' دحوو104م ',' اعترف باي حاجه ؟ ')
name = string.gsub(name,' دحوو105م ',' عبّر عن مودك بصوره ؟ ')
name = string.gsub(name,' دحوو106م ',' اسم دايم ع بالك ؟ ')
name = string.gsub(name,' دحوو107م ',' اشياء تفتخر انك م سويتها ؟ ')
name = string.gsub(name,' دحوو108م ','  لو بكيفي كان ؟ ')
name = string.gsub(name,' دحوو109م ',' تحب تحتفظ بالذكريات ؟ ')
name = string.gsub(name,' دحوو110م ',' اغلب وقتك ضايع في؟ ')
name = string.gsub(name,' دحوو111م ',' اكثر كلمة تنقال لك بالبيت ؟ ')
name = string.gsub(name,' دحوو112م ',' كلمتك التسليكيه ؟ ')
name = string.gsub(name,' دحوو113م ',' تزعلك الدنيا ويرضيك ؟ ')
name = string.gsub(name,' دحوو114م ',' عندك فوبيا او خوف شديد من شيء معين ؟ ')
name = string.gsub(name,' دحوو115م ','  غزل بلهجتك ؟ ')
name = string.gsub(name,' دحوو116م ',' ردة فعلك لما تنظلم من شخص ؟ ')
name = string.gsub(name,' دحوو117م ',' شيء تعترف انك فاشل فيه ؟ ')
name = string.gsub(name,' دحوو118م ',' اكثر كلمة ترفع ضغطك ؟ ')
name = string.gsub(name,' دحوو119م ',' نسبة جمال صوتك ؟ ')
name = string.gsub(name,' دحوو120م ',' كيف تتعامل مع الشخص المُتطفل ( الفضولي ) ؟ ')
name = string.gsub(name,' دحوو121م ',' من الاشياء اللي تجيب لك الصداع ؟ ')
name = string.gsub(name,' دحوو122م ',' حصلت الشخص اللي يفهمك ولا باقي ؟ ')
return '-› '..name..'  ' 
end
if MsgText[1] == 'عكس' or MsgText[1] == 'العكس' or MsgText[1] == '' then   
redis:set(boss.."GAME:S"..msg.chat_id_,true) 
H1 = [[
عكس كلمه  ⇠ (مافهمت) 
]]
H2 = [[
عكس كلمه  ⇠ (جبان) 
]]
H3 =[[
عكس كلمه  ⇠ (ميت) 
]]
H4 =[[
عكس كلمه  ⇠ (كسول) 
]]
H5 =[[
عكس كلمه  ⇠ (زين) 
]]
H6 =[[
عكس كلمه  ⇠ (عطشان) 
]]

H7 =[[
عكس كلمه  ⇠ (بارده) 
]]
H8 =[[
عكس كلمه  ⇠ (خايف) 
]]
H9 =[[
عكس كلمه  ⇠ (امام) 
]]
H11 =[[
عكس كلمه  ⇠ (خاين) 
]]
H12 =[[
عكس كلمه  ⇠ (طويل) 
]]
H13 =[[
عكس كلمه  ⇠ (صلب) 
]]
H14 =[[
عكس كلمه  ⇠ (ناعم) 
]]
H15 =[[
عكس كلمه  ⇠ (مجنون) 
]]
H16 =[[
عكس كلمه  ⇠ (غبي) 
]]
H17 =[[
عكس كلمه  ⇠ (ظلمه) 
]]
H18 =[[
عكس كلمه  ⇠ (مسموح) 
]]
H19 =[[
عكس كلمه  ⇠ (ماسمعك) 
]]

H20 =[[
عكس كلمه  ⇠ (تعال) 
]]
HUSSEIN = {H16,H17,H18,H19,H20,H1,H2,H3,H4,H5,H6,H7,H8,H9,H11,H12,H13,H14,H15}
local SENDTEXT = HUSSEIN[math.random(#HUSSEIN)]
if SENDTEXT:find('فهمت') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'فهمت') 
elseif SENDTEXT:find('مو جبان') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مو جبان') 
elseif SENDTEXT:find('عدل') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'عدل') 
elseif SENDTEXT:find('نشط') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'نشط') 
elseif SENDTEXT:find('مو زين') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مو زين') 
elseif SENDTEXT:find('مو عطشان') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مو عطشان') 
elseif SENDTEXT:find('حاره') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'حاره') 
elseif SENDTEXT:find('مو خايف') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مو خايف') 
elseif SENDTEXT:find('خلف') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'خلف') 
elseif SENDTEXT:find('وفي') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'وفي') 
elseif SENDTEXT:find('قزم') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'قزم') 
elseif SENDTEXT:find('لين') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'لين') 
elseif SENDTEXT:find('خشن') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'خشن') 
elseif SENDTEXT:find('عاقل') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'عاقل') 
elseif SENDTEXT:find('ذكي') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'ذكي') 
elseif SENDTEXT:find('مو ظلمه') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مو ظلمه') 
elseif SENDTEXT:find('مو مسموح') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'مو مسموح') 
elseif SENDTEXT:find('اسمعك') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'اسمعك') 
elseif SENDTEXT:find('روح') then
redis:set(boss.."GAME:CHER"..msg.chat_id_,'روح') 
end
sendMsg(msg.chat_id_,msg.id_,SENDTEXT)     
return false  
end

if MsgText[1] == 'مجوهراتي' then 
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_)
if points and points ~= "0" then
return '* ⇠عدد المجوهرات اللي جمعتها هي ( '..points..' )\n ⇠ يمديك تبيع مجوهراتك وتاخذ (100) رساله مقابل كل جوهره من المجوهرات *\n'
else
return ' *⇠ ماعندك مجوهرات ،\n⇠ عشان تحصل المجوهرات ،\n ⇠ارسل الالعاب وابدأ اللعب ! *'
end
end
if MsgText[1] == 'بيع مجوهراتي' then
if MsgText[2] == "0" then
return '⇠ فيه خطأ عزيزي  \n⇠ لازم يكون البيع ع الاقل 1 من المجوهرات . 'end
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_)
if tonumber(MsgText[2]) > tonumber(points) then
return '⇠ ماعندك مجوهرات بذا العدد عشان ابيعهم!' 
end
if points == "0" then
return '⇠للاسف ليس لديك المجوهرات \n🔖╽للحصول على المجوهرات العب احد الالعاب الموجوده في `قائمه الالعاب`'
else
local Total_Point = MsgText[2] * 100
redis:decrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,MsgText[2])  
redis:incrby(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_,Total_Point)  
return " ⇠ تم خصمت (* "..MsgText[2].." *) من مجوهراتك\n⇠ وزدت لك ( * "..Total_Point.."* ) رساله \n⇠ وصارت رسائلك ( *"..redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_).."* ) رساله\n"
end
end
if MsgText[1] == "الالعاب" or MsgText[1] == "اللعبه" or MsgText[1] == "اللعبة" then
return [[ 
⤶  العاب []]..redis:get(boss..':NameBot:')..[[]  🏌🏻‍♂️ 
⇠  لتفعيل الالعاب او تعطيلها ارسل
⇠  تفعـيل ⇠ تعطيل ⇠ الالعاب
ꔹ┉ ┉ ┉ ┉ ┉ ┉ ┉ꔹ
• امثله ⇠ لعبه امثله قديمه
• معاني ⇠ لعبه معاني لسمايلات 
•اسئله ⇠ لعبه اسئله عامه
• روليت ⇠ لعبه الروليت الشهيره
• حزوره ⇠ لعبه الحزورات
• ترتيب ⇠ لعبه ترتيب الكلمات
• العكس ⇠ لعبه عكس الكلمه
• تخمين ⇠ لعبه تخمين الكلمه 
• الاسرع ⇠ لعبه اسرع واحد 
• كت تويت ⇠ لعبه التسليه 
• انقليزي ⇠ لعبه ترجمة انقليزي
• تفكيك ⇠ لعبه تفكيك الكلمات
• تركيب ⇠ لعبه تركيب الكلمات
• رياضيات ⇠ لعبة الرياضيات
• محيبس ⇠ لعبه محيبس الشهيره
• المختلف ⇠ لعبه اختلاف لسمايل
ꔹ┉ ┉ ┉ ┉ ┉ ┉ ┉ꔹ
  ⇠ مجوهراتي ⇠ عشان تشوف عدد مجوهراتك 
⇠ بيع مجوهراتي + العدد للأستبدال ⇺

]]
end
if MsgText[1] == 'روليت' then
redis:del(boss..":Number_Add:"..msg.chat_id_..msg.sender_user_id_) 
redis:del(boss..':List_Rolet:'..msg.chat_id_)  
redis:setex(boss..":Start_Rolet:"..msg.chat_id_..msg.sender_user_id_,3600,true)  
return '⇠ تمام لنلعب , ارسل عدد اللاعبين للروليت .'
end
if MsgText[1] == 'نعم' and redis:get(boss..":Witting_StartGame:"..msg.chat_id_..msg.sender_user_id_) then
local list = redis:smembers(boss..':List_Rolet:'..msg.chat_id_) 
if #list == 1 then 
return "⇠لم يكتمل العدد الكلي للاعبين .!؟" 
elseif #list == 0 then 
return "⇠عذرا لم تقوم باضافه اي لاعب .؟!" 
end 
local UserName = list[math.random(#list)]
GetUserName(UserName,function(arg,data)
redis:incrby(boss..':User_Points:'..msg.chat_id_..data.id_,5)
end,nil)
redis:del(boss..':List_Rolet:'..msg.chat_id_) 
redis:del(boss..":Witting_StartGame:"..msg.chat_id_..msg.sender_user_id_)
return '⇠ واخترنا صاحب الحظ هذا\n- المحظوظ (['..UserName..'])\n- فزت معنا ب 5 مجوهرات' 
end
if MsgText[1] == 'الاعبين' then
local list = redis:smembers(boss..':List_Rolet:'..msg.chat_id_) 
local Text = '\n*ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ*\n' 
if #list == 0 then 
return '** لا يوجد لاعبين هنا ' 
end 
for k, v in pairs(list) do 
Text = Text..k.."•   ⇠ [" ..v.."]  ⇠\n"  
end 
return Text
end
if MsgText[1] == 'قائمه الالعاب' then
sendMsg(msg.chat_id_,msg.id_,[[
  *العاب ارماندو*  🎖  
⇠  لتفعيل الالعاب او تعطيلها ارسل
⇠  تفعـيل ⇠ تعطيل ⇠ الالعاب
ꔹ┉ ┉ ┉ ┉ ┉ ┉ ┉ꔹ
• امثله ⇠ لعبه امثله قديمه
• معاني ⇠ لعبه معاني لسمايلات 
•اسئله ⇠ لعبه اسئله عامه
• روليت ⇠ لعبه الروليت الشهيره
• حزوره ⇠ لعبه الحزورات
• ترتيب ⇠ لعبه ترتيب الكلمات
• العكس ⇠ لعبه عكس الكلمه
• تخمين ⇠ لعبه تخمين الكلمه 
• الاسرع ⇠ لعبه اسرع واحد 
• كت تويت ⇠ لعبه التسليه 
• انقليزي ⇠ لعبه ترجمة انقليزي
• تفكيك ⇠ لعبه تفكيك الكلمات
• تركيب ⇠ لعبه تركيب الكلمات
• رياضيات ⇠ لعبة الرياضيات
• محيبس ⇠ لعبه محيبس الشهيره
• المختلف ⇠ لعبه اختلاف لسمايل
ꔹ┉ ┉ ┉ ┉ ┉ ┉ ┉ꔹ
  ⇠ مجوهراتي ⇠ عشان تشوف عدد مجوهراتك 
⇠ بيع مجوهراتي + العدد للأستبدال ⇺

]])
end
end
end
end
local function procces(msg)
if msg.text and not redis:get(boss..'lock_geams'..msg.chat_id_) then
if msg.text == redis:get(boss..':Set_alii:'..msg.chat_id_) then -- // المختلف
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_alii:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'كفو اجابتك صح')
end

if msg.text == redis:get(boss..':Set_Amthlh:'..msg.chat_id_) then -- // امثله
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_Amthlh:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*     كفو اجابتك صح  \n*   \n')
end

if msg.text == redis:get(boss..':Set_trkib:'..msg.chat_id_) then -- // تركيب
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_trkib:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*• كفو اجابتك صح   \n*   \n')
end
if msg.text == redis:get(boss..':Set_ang:'..msg.chat_id_) then -- // النجليزي
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_ang:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*•    كفو اجابتك صح \n*   \n')
end

if msg.text == redis:get(boss..':Set_ria:'..msg.chat_id_) then -- // رياضيات
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_ria:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*• كفو اجابتك صح     \n*   \n')
end

if msg.text == redis:get(boss..':Set_fkk:'..msg.chat_id_) then -- // تفكيك
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_fkk:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*•   كفو اجابتك صح   \n*   \n')
end

if msg.text == redis:get(boss..':Set_Smile:'..msg.chat_id_) then --//  الاسرع
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_Smile:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*كفو اجابتك صح \n*   \n')
end 
if msg.text == redis:get(boss..':Set_alii:'..msg.chat_id_) then -- // المختلف
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_alii:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*     كفو اجابتك صح    \n*   \n')
end 
if msg.text == redis:get(boss..':Set_Hzorh:'..msg.chat_id_) then -- // حزوره
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_Hzorh:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*  كفو اجابتك صح   \n*   \n')
end 
if msg.text == redis:get(boss..':Set_Arg:'..msg.chat_id_) then -- // الترتيب
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_Arg:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*    كفو اجابتك صح \n*   \n')
end 
if msg.text == redis:get(boss..':Set_Name_Meant:'..msg.chat_id_) then --// المعاني
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss..':Set_Name_Meant:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'*  كفو اجابتك صح    \n*   \n')
end 
if msg.text:match("^(%d+)$") and redis:get(boss..":Start_Rolet:"..msg.chat_id_..msg.sender_user_id_) then  --// استقبال اللعبه الدمبله
if msg.text == "1" then
Text = "** لا استطيع بدء اللعبه بلاعب واحد فقط\n"
else
redis:set(boss..":Number_Add:"..msg.chat_id_..msg.sender_user_id_,msg.text)  
Text = '⇠ تم الحين نبدأ نسجل اللسته \n- ياليت ترسل المعرفات \n- الفايز ياخذ (5) مجوهرات\n- عدد الاعبين المطلوب ( *'..msg.text..'* )  \n '
end
redis:del(boss..":Start_Rolet:"..msg.chat_id_..msg.sender_user_id_)  
return sendMsg(msg.chat_id_,msg.id_,Text)    
end
if msg.text:match('^(@[%a%d_]+)$') and redis:get(boss..":Number_Add:"..msg.chat_id_..msg.sender_user_id_) then    --// استقبال الاسماء
if redis:sismember(boss..':List_Rolet:'..msg.chat_id_,msg.text) then
return sendMsg(msg.chat_id_,msg.id_,'** المعرف (['..msg.text..']) موجود اساسا' )
end
redis:sadd(boss..':List_Rolet:'..msg.chat_id_,msg.text)
local CountAdd = redis:get(boss..":Number_Add:"..msg.chat_id_..msg.sender_user_id_)
local CountAll = redis:scard(boss..':List_Rolet:'..msg.chat_id_)
local CountUser = CountAdd - CountAll
if tonumber(CountAll) == tonumber(CountAdd) then 
redis:del(boss..":Number_Add:"..msg.chat_id_..msg.sender_user_id_) 
redis:setex(boss..":Witting_StartGame:"..msg.chat_id_..msg.sender_user_id_,1400,true)  
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم سجلت اليوزر ( ["..msg.text.."] ) \n- وتم اكتمل العدد  \n- هل انت مستعد ؟ ارسل ( نعم )")
end 
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم سجلت اليوزر ( ["..msg.text.."] ) \n ⇠ باقي ( *"..CountUser.."* ) لاعبين عشان يكتمل العدد\nارسل اليوزر الي بعده ")
end
end 
if redis:get(boss.."SETEX:MSG"..msg.chat_id_..""..msg.sender_user_id_) then 
if msg.text:match("^(%d+)$") then
if tonumber(msg.text:match("^(%d+)$")) > 99999999990 then
sendMsg(msg.chat_id_,msg.id_,"*⇠ مايمديك تضيف اكثر من 99999999990 رساله\n*")
redis:del(boss.."SETEX:MSG"..msg.chat_id_..""..msg.sender_user_id_)  
return false  end 
local GET_IDUSER = redis:get(boss..'SET:ID:USER'..msg.chat_id_)  
sendMsg(msg.chat_id_,msg.id_,"\nابشر اضفت له ( "..msg.text.." ) رساله")
redis:incrby(boss..'msgs:'..GET_IDUSER..':'..msg.chat_id_,msg.text)  
end
redis:del(boss.."SETEX:MSG"..msg.chat_id_..""..msg.sender_user_id_)  
end
if redis:get(boss.."SETEX:NUM"..msg.chat_id_..""..msg.sender_user_id_) then 
if msg.text:match("^(%d+)$") then
if tonumber(msg.text:match("^(%d+)$")) > 99999999990 then
sendMsg(msg.chat_id_,msg.id_,"*⇠ مايمديك تضيف اكثر من 99999999990 مجوهره\n*")   
redis:del(boss.."SETEX:NUM"..msg.chat_id_..""..msg.sender_user_id_)  
return false  end 
local GET_IDUSER = redis:get(boss..'SET:ID:USER:NUM'..msg.chat_id_)  
sendMsg(msg.chat_id_,msg.id_,"\n⇠ تم اضفت له ( "..msg.text.." ) مجوهرات")
redis:incrby(boss..':User_Points:'..msg.chat_id_..GET_IDUSER,msg.text)  
end
redis:del(boss.."SETEX:NUM"..msg.chat_id_..""..msg.sender_user_id_)  
end
if redis:get(boss.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if msg.text:match("^(%d+)$") then
local NUM = msg.text:match("^(%d+)$")
if tonumber(NUM) > 6 then
sendMsg(msg.chat_id_,msg.id_,"*⇠ عذرا مافيه الى ( 6 ) اختيارات بس ارسل اختيارك مره ثانية*\n")   
return false  end 
local GETNUM = redis:get(boss.."GAMES"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(boss.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
sendMsg(msg.chat_id_,msg.id_,'* ⇠مبروك فزت وطلعت المحيبس في اليد رقم ( '..NUM..' )\n⇠لقد حصلت على ( 3 )من مجوهرات يمكنك استبدالهن برسائل *')   
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del(boss.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
sendMsg(msg.chat_id_,msg.id_,'\n*⇠ للاسف خسرت \n⇠ المحيبس في اليد رقم ( '..GETNUM..' )\n حاول مره ثانيه عشان تحصل المحيبس *')   
end
end
end
if (msg.text == redis:get(boss.."GAME:CHER"..msg.chat_id_)) and redis:get(boss.."GAME:S"..msg.chat_id_) then  
sendMsg(msg.chat_id_,msg.id_,'كفو اجابتك صح')     
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss.."GAME:S"..msg.chat_id_)
redis:del(boss.."GAME:CHER"..msg.chat_id_)
elseif msg.text == 'الفيل' or msg.text == 'الثور' or msg.text == 'الحصان' or msg.text == '7' or msg.text == '9' or msg.text == '8' or msg.text == 'لوين' or msg.text == 'موسكو' or msg.text == 'مانكو' or msg.text == '20' or msg.text == '30' or msg.text == '28' or msg.text == 'ترامب' or msg.text == 'اوباما' or msg.text == 'كيم جونغ' or msg.text == '50' or msg.text == '70' or msg.text == '40' or msg.text == '7' or msg.text == '3' or msg.text == '10' or msg.text == '4' or msg.text == 'الاذن' or msg.text == 'الثلاجه' or msg.text == 'الغرفه' or msg.text == '15' or msg.text == '17' or msg.text == '25' or msg.text == 'الفرات' or msg.text == 'نهر الكونغو' or msg.text == 'المسيبي' or msg.text == 'بيا بايج' or msg.text == 'لاري بيج' or msg.text == 'بيا مارك زوكيربرج' or msg.text == 'الفيل' or msg.text == 'النمر' or msg.text == 'الفهد' or msg.text == 'بانكول' or msg.text == 'نيو دلهي' or msg.text == 'بيكن' or msg.text == 'الهاتف' or msg.text == 'التلفاز' or msg.text == 'المذياع' or msg.text == 'لفرسول' or msg.text == 'تركيا' or msg.text == 'بغداد' or msg.text == 'النحاس' or msg.text == 'الحديد' or msg.text == 'الفضه' or msg.text == 'امريكا الشماليه' or msg.text == 'امريكا الجنوبيه' or msg.text == 'افريقيا' or msg.text == 'القرش' or msg.text == 'الثعلب' or msg.text == 'الكلب' or msg.text == 'للجرو' or msg.text == 'العجل' or msg.text == 'الحمار' or msg.text == '3' or msg.text == '5' or msg.text == '6' or msg.text == 'اوربا' or msg.text == 'افريقيا' or msg.text == 'امريكا الجنوبيه' or msg.text == 'افريقيا' or msg.text == 'امريكا الشماليه' or msg.text == 'اوربا' or msg.text == 'الصاروخ' or msg.text == 'المسدس' or msg.text == 'الطائرات' or msg.text == 'سيدات' or msg.text == 'قوانص' or msg.text == 'عوانس' or msg.text == 'المكارم' or msg.text == 'المبائم' or msg.text == 'المعازم' or msg.text == 'حرف الغاء' or msg.text == 'حرف الواو' or msg.text == 'حرف النون' or msg.text == 'نحاس' or msg.text == 'الماس' or msg.text == 'حديد' or msg.text == 'العمر' or msg.text == 'ساعه' or msg.text == 'الحذاء' or msg.text == 'بئر' or msg.text == 'نهر' or msg.text == 'شلال' or msg.text == 'ادم' or msg.text == 'نوح' or msg.text == 'عيسئ' or msg.text == 'الاضافر' or msg.text == 'الاسنان' or msg.text == 'الدموع' or msg.text == 'الاخلاق' or msg.text == 'الضل' or msg.text == 'حرف النون'  then
if redis:get(boss.."GAME:S"..msg.chat_id_) then  
local list = {'10' , 'براسي' , 'النمل' , '32' , 'بوتين' , '30' , '11' , 'الفم' , '14' , 'النيل' , 'ستيف جوبر' , 'خديجه' , 'الاسد' , 'طوكيو' , 'الانسان' , 'لندن' , 'الزئبق' , 'اورباالدولفين' , 'المهر' , '4' , 'اسيا' , 'اسيا' , 'المنجنيق' , 'انسات' , 'العزائم' , 'حرف الام' , 'ذهب' , 'الاسم' , 'سحاب' , 'ابراهيم' , 'الشعر' , 'حرف الواو'}
for k, v in pairs(list) do 
if msg.text ~= v then
sendMsg(msg.chat_id_,msg.id_,'اجابتك غلطططط ')     
redis:del(boss.."GAME:S"..msg.chat_id_)
redis:del(boss.."GAME:CHER"..msg.chat_id_)
return false  
end
end
end
end
if (msg.text == redis:get(boss.."GAME:CHER"..msg.chat_id_)) and redis:get(boss.."GAME:S"..msg.chat_id_) then  
sendMsg(msg.chat_id_,msg.id_,'كفو اجابتك صح')     
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss.."GAME:S"..msg.chat_id_)
redis:del(boss.."GAME:CHER"..msg.chat_id_)
elseif msg.text == 'فهمت' or msg.text == 'مو جبان' or msg.text == 'عدل' or msg.text == 'نشط' or msg.text == 'مو زين' or msg.text == 'مو عطشان' or msg.text == 'حاره' or msg.text == 'مو خايف' or msg.text == 'خلف' or msg.text == 'وفي' or msg.text == 'القزم' or msg.text == 'لين' or msg.text == 'خشن' or msg.text == 'عاقل' or msg.text == 'ذكي' or msg.text == 'مو ظلمه' or msg.text == 'مو مسموح' or msg.text == 'اسمعك' or msg.text == 'روح' then
if redis:get(boss.."GAME:S"..msg.chat_id_) then  
local list = {'فهمت' , 'مو جبان' , ' مو عطشان' , 'عدل' , 'نشط' , 'مو زين' , ' خاره ' , 'خلف' , 'مو خايف' , 'لين' , 'القزم' , 'وفي' , 'عاقل' , 'خشن' , 'ذكي' , 'اسمعك' , 'مو مسموح' , 'مو ظلمه'}
for k, v in pairs(list) do 
if msg.text ~= v then
sendMsg(msg.chat_id_,msg.id_,'كفو اجابتك صح')     
redis:incrby(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_,1)  
redis:del(boss.."GAME:S"..msg.chat_id_)
redis:del(boss.."GAME:CHER"..msg.chat_id_)
return false  
end
end
end
end
if redis:get(boss.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if msg.text:match("^(%d+)$") then
local NUM = msg.text:match("^(%d+)$")
if tonumber(NUM) > 20 then
sendMsg(msg.chat_id_,msg.id_,"*⇠ مايمديك تخمين عدد اكبر من ال ( 20 ) خمن رقم ما بين ال( 1 و 20 ) *\n")
return false  end 
local GETNUM = redis:get(boss.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(boss..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby(boss..':User_Points:'..msg.chat_id_..data.id_,5)
sendMsg(msg.chat_id_,msg.id_,'*⇠ كفو فزت معنا وخمنت الرقم صح تم اضفت لك ( 5 ) مجوهرات\n *\n')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(boss..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get(boss..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del(boss..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
sendMsg(msg.chat_id_,msg.id_,'\n*⇠ للاسف خسرت باللعبة \n⇠ موفق بالمرات الجايه \n⇠ كان الرقم اللي خمنته ( '..GETNUM..' )\n*')
else
sendMsg(msg.chat_id_,msg.id_,'\n* ⇠  تخمينك غلط \n⇠ ارسل رقم تخمنه مره ثانيه \n*')
end
end
end
end

end
return {
Boss = {
"^(حزوره)$", 
"^(المختلف)$",
 "^(امثله)$",
"^(نعم)$",
"^(الاعبين)$",
"^(بدء الاسئله)$",
"^(ختيارات)$",
"^(اسئله)$",
"^(الالعاب)$",
"^(محيبس)$",
   "^(تركيب)$",
"^(تخمين)$",
"^(خمن)$",
"^(بات)$",
'^(تعطيل) (.+)$',
'^(تفعيل) (.+)$',
"^(اسرع)$",
  "^(تفكيك)$",
"^(الاسرع)$",
"^(مجوهراتي)$",
"^(ترتيب)$",
"^(معاني)$",
"^(عكس)$",
"^(العكس)$", 
"^(العكسس)$", 
"^(بيع مجوهراتي) (%d+)$",
"^(اضف رسائل) (%d+)$",
"^(اضف مجوهرات) (%d+)$",
"^(روليت)$",
"^(رياضيات)$",
"^(الرياضيات)$",
"^(انقليزي)$",
"^(كت تويت)$",
"^(كت)$",
"^(تويت)$",
"^(الانقليزي)$",
"^(قائمه الالعاب)$",
 },
 iBoss = games,
 dBoss = procces,
 }
