#!/usr/bin/env python3
from openai import OpenAI
import rospy
from std_msgs.msg import String

api_key = "sk-aTDemqxcD49oRFND5oeoSRbVaQSNtt10eRUgWTDiQ4xBsZZn"
base_url = "https://api.moonshot.cn/v1"

class LLM(OpenAI):
    def __init__(self):
        super().__init__(api_key=api_key, base_url=base_url)
        self.model = "moonshot-v1-8k"
        self.system_role_content = "你是Kimi,由Moonshot AI提供的人工智能助手, \ 我们将会叫你的小名“小月”,你不会在你的回答中提及你的小名,你更擅长中文和英文的对话. \ 你会为用户提供安全,有帮助,准确的回答. \ 同时,你会拒绝一切涉及恐怖主义,种族歧视,黄色暴力等问题的回答"
        # 多轮对话记忆（关键）
        self.messages = [{"role": "system", "content": self.system_role_content}]
        rospy.init_node('robot_voice_llm_node', anonymous=True)
        rospy.Subscriber("/speech/result", String, self.speech_result_callback)
        self.tts_pub = rospy.Publisher("/talk", String, queue_size=10)

    def speech_result_callback(self, msg):
        result = msg.data
        print("speech [{}]".format(result))
        if result:
            try:
                chat_response = self.query(result)
                indented_response = "\n".join(f"\t{line}" for line in chat_response.splitlines())
                print(f"LLM的返回结果: \n\n'''\n{indented_response}\n'''")
                # 清理文字，不报错
                clean_text = chat_response.replace('\n', '').replace('\t', '').replace('*', '').replace("'", "").replace('"', '').replace(':', '').strip()
                self.tts_pub.publish(clean_text)
            except Exception as e:
                if "rate_limit_reached" in str(e):
                    print("请求超限")
                else:
                    print("出错啦")

    def query(self, user_prompt):
        # 把用户说的话加入记忆
        self.messages.append({"role": "user", "content": user_prompt})
        completion = self.chat.completions.create(
            model=self.model,
            messages=self.messages,
            temperature=0.1,
            stream=False
        )
        reply = completion.choices[0].message.content
        # 把AI回答也加入记忆
        self.messages.append({"role": "assistant", "content": reply})
        return reply

if __name__ == "__main__":
    try:
        llm = LLM()
        rospy.spin()
    except KeyboardInterrupt:
        print("\nCaught Ctrl + C. Exiting")

