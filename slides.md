---
theme: default
class: 'text-center'
highlighter: shiki
lineNumbers: true
info: |
  slide for CTOA 若手エンジニアコミュニティオフライン勉強会#2
css: unocss
---

# 🦜🔗
# LangChain が解決したいこと 
##### CTOA若手エンジニアコミュニティ オフライン勉強会#2

<p>
  <a href="https://yoiw.dev" target="_blank">yoiwamoto</a>
</p>


<div class="abs-br m-6 flex gap-2">
  <button @click="$slidev.nav.openInEditor()" title="Open in Editor" class="text-xl slidev-icon-btn opacity-50 !border-none !hover:text-white">
    <carbon:edit />
  </button>
  <a href="https://github.com/slidevjs/slidev" target="_blank" alt="GitHub"
    class="text-xl slidev-icon-btn opacity-50 !border-none !hover:text-white">
    <carbon-logo-github />
  </a>
</div>



---
layout: image-right
image: https://pbs.twimg.com/profile_images/1627211617820868609/JBx_xJa-_400x400.jpg

---

<Heading text="About me" />
<div class="pt-16 text-lg">

- フロントエンドエンジニア@PR TIMES  

- 22卒

- インターネットでの名前が欲しい（定期）

- 例によって、オフラインであることに甘んじて適当なことを言います

</div>



---
layout: center

---

# OpenAI やばすぎでは？🤔



---
layout: two-cols

---

<Tweet id="1598014522098208769" class="max-w-4/5 mx-auto" />

::right::

<Tweet id="1635687373060317185" class="max-w-4/5 mx-auto" />



---
layout: center

---


<h1>絶対なんかすごいもの作るぞ😠</h1>

<v-click>

<h4 class="text-right">と思ってから、無事2週間が経ちましたね（ちくちく言葉）</h4>

</v-click>



---

<Heading text="AI 機能、思ったよりめんどくさい" />

<div class="pt-12 flex flex-col gap-4">

考えることが意外と色々あります。

- 多くのユースケースで、1:1の問答で解決する課題は少ない
  - LLM がコンテキストを理解するために、**セッションとメモリの管理・プロンプト**が必要

- アプリケーション上の何かをトリガーにしてプロンプトを投げ、回答をアプリケーションに反映するだけの機能は、今のところ多くの場合入出力が自然言語のまま → ChatGPT の UI で済む
  - 固有の機能・独自性を出すには、**embedding が必要になることが多い** 

</div>



---
layout: center
---

<img src="/img/dc070589-d0da-4d5b-b744-49817b55b834.png" alt="" class="w-80 mx-auto" />

<p>カラーコード → 色の名前を AI に聞くサービスもありましたね...</p>



--- 
layout: center
---

<Heading text="🦜🔗LangChain とは" />

<div class="p-20">
  <img src="/img/7b358d90-961a-4036-b110-f963a862fb77.png" alt="" />
</div>



---

<Heading text="何ができるのか" />

<div class="text-3xl pt-8">

- Models
- Prompts
- Indexes
- Memory
- Chains
- Agents

</div>



--- 

<Heading text="Chains" />

<div class="pt-8 text-3zl">

```python {all|1-5|7-13|15-16|18|all}
from langchain.chat_models import ChatOpenAI
from langchain.prompts.chat import (
    ChatPromptTemplate,
    HumanMessagePromptTemplate,
)

human_message_prompt = HumanMessagePromptTemplate(
    prompt=PromptTemplate(
        template="What is a good name for a company that makes {product}?",
        input_variables=["product"],
    )
)
chat_prompt_template = ChatPromptTemplate.from_messages([human_message_prompt])

chat = ChatOpenAI(temperature=0.9)
chain = LLMChain(llm=chat, prompt=chat_prompt_template)

print(chain.run("colorful socks"))
```

</div>



--- 

<Heading text="Chains" />

<div class="pt-8 text-3zl">

```python {all|3-8|9|12-13|all}
from langchain.chains import SimpleSequentialChain

second_prompt = PromptTemplate(
    input_variables=["company_name"],
    template="Write a catchphrase for the following company: {company_name}",
)
chain_two = LLMChain(llm=llm, prompt=second_prompt)

overall_chain = SimpleSequentialChain(chains=[chain, chain_two], verbose=True)

# Run the chain specifying only the input variable for the first chain.
catchphrase = overall_chain.run("colorful socks")
print(catchphrase)
```

</div>

---
layout: center

---

# この機能いるか？🤔



--- 

<Heading text="データの民主化" />

<div class="pt-4 flex flex-col gap-3">

<div>

具体例のために一瞬話が逸れますが、最近ばんくしさんが、データの民主化について書いていました。

データの民主化とこれからのAI組織  
https://note.com/vaaaaanquish/n/n228744f30bf3

</div>

<div>

(AI 開発について1ミリも知らないので語弊を含んでいるかと思いますが)

大規模なデータやそれによって train された AI モデルの使用は、これまではデータを保有しているビッグテックの特権だった。  
→ 既に大量のデータで学習済みのモデルが一般に利用可能になったことで、データが（AI 活用が）民主化された。

とはいえ、その先を目指すなら自社データなどで学習し、プロダクトに最適化されたモデルが有効に働く↓

> 「データドリブンでなんとか」を本当にやらないといけないのはどこか、ROIは立っているのか、**90点モデル以上の価値が出せるのか**、データ基盤もAI人材もかなり強く追求されるようになるんじゃなかろうか。  

<p class="text-right -translate-y-2">- 引用</p>

</div>

</div>



---

<Heading text="Chain の利用" />

<div class="pt-4">

例えばですが、Chain はこういう用途で使うことが多いんだろうなと思っています。

<v-click>

**PR TIMES の UI**：「何についてのリリースですか？」

</v-click>
<v-click>

↓  
**ユーザー**：「中途採用のミスマッチを解消するマッチングサービスの "ジョブコネクト"」

</v-click>
<v-click>

↓  
「${ユーザー入力} についてのプレスリリースのタイトルを考えてください」と LLM にプロンプト **← chain!**

</v-click>
<v-click>

↓  
**LLM**：「新登場：「ジョブコネクト」─ 中途採用のミスマッチを解消する革新的マッチングサービスが誕生！」

</v-click>
<v-click>

<div>

↓  
PR TIMES 内のプレスリリースに最適化されたモデルが、サブタイトル、リード文に含めるのに相応しいキーワードや文体、内容を提案 **← chain!**

<p class="text-right">以下略、91点以上を目指す社内のモデルと chain していく役割</p>
</div>

</v-click>


</div>



---

<Heading text="Agent と Plugin" />

<div class="pt-4 flex flex-col gap-6">

<p>
Plugin は、LLM では実現できない機能を補うもの  
ex) ブラウジング、商品の在庫情報問い合わせ
</p>

<v-click>

<div>

ChatGPT Plugin では、API 実装と OpenAPI specification を ChatGPT に公開して、その機能を使用するかどうかの制御は ChatGPT に委ねられる。← **Agent**

https://platform.openai.com/docs/plugins/getting-started/running-a-plugin

</div>

</v-click>
<v-click>

<div>

LangChain の agent を使えば、Plugin はローカルや何かしら internal な環境に構築されていても chains に組み込み可能

→ よりオープンに、OpenAI のプラットフォームに乗らずに Plugin を構築・組み込みできる。

</div>

</v-click>

</div>



---
layout: center

---

# AI 組み込み、やっていきましょう