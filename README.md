CHANGES:
1. เปลี่ยนส่วนที่เป็น `public` ที่ผู้เล่นไม่จำเป็นต้องเห็นให้เป็น `private`
2. สร้าง `mapping (address => uint) private playerIdx` สำหรับการค้นหา idx ของผู้เล่นโดยใช้ address ในการหา
3. แก้ฟังก์ชั่น `input` ให้ไม่ต้องรับ idx
4. สร้างตัวแปร `lastActionTime` เก็บค่าเวลาล่าสุดที่เกิดแอกชั่นจากฝ่ายใดฝ่ายหนึ่งขึ้น จะอัพเดตเมื่อมีการใช้ `addplayer` `input` หรือ `confirmInput`
5. สร้างฟังก์ชั่น `reset` สำหรับคืนค่าเริ่มต้นให้กับเกมสำหรับเมื่อเกมจบแล้ว
6. ใส่การเรียกฟังก์ชั่น `reset` เพิ่มในทุกกรณีที่มีการจบเกม
7. เพิ่มฟังก์ชั่น `leave` ให้ผู้เล่นที่รอการแอกชั่นจากอีกฝ่ายนานเกิน 5 นาทีสามารถถอนตัว แล้วจะคืนเงินให้กับทั้ง 2 ฝ่าย รวมถึงคืนค่าเริ่มต้นให้กับเกม
8. แก้ฟังก์ชั่น `_checkWinnerAndPay` กับ `input` ให้รองรับทั้ง 7 RWAPSSF
9. ใช้การ commit-reveal โดยแก้ไขให้ `input` รับ salt เพิ่มมาและไม่แสดง choice โดยทันทีแต่ให้ commit โดยใช้ salt ที่ผู้เล่นใส่เอง
10. สร้างฟังก์ชั่น `confirmInput` โดยหลังจากที่ทุกคน input มาแล้ว จะต้องใส่ choice กับ salt ที่เหมือนเดิมอีกรอบเพื่อทำการ reveal เมื่อได้ reveal ทั้ง 2 ฝ่ายแล้วจะทำการเรียก `_checkWinnerAndPay`
    
SCREENSHOTS:
added 2 players

![added 2 players](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/a7c3d7b6-4372-4de0-acf9-4f1c6509000e)

both players input a choice

![p0 input](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/29af2cf1-30b6-4442-80e9-58a5daf1c6b0)
![p1 input](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/27d31762-2008-4bf7-8ef1-8963a84d8a39)

one player reveals their choice - nothing happened yet

![p1 reveal](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/4eeedd93-b5d4-4127-a308-17c8395aee48)

both player reveals their choices - checks winner, pay and resets the game

![p0 reveal](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/dbb4fcb8-df6a-4ea0-a66f-fb7315f0e127)

![check winner](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/0bba29ef-6b92-4f3b-bb15-5e6edd024043)

if a draw happens

![check draw](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/bfde31cb-5e67-43be-9505-8b8c67c4b03f)

if someone left early

![leave](https://github.com/nammonman/contract-RWAPSSF/assets/110343092/6034668a-9429-48c6-8f73-e24924c6839b)


