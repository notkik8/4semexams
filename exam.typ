// --- НАСТРОЙКА КРАСИВОГО ШАБЛОНА ДЛЯ ЭКЗАМЕНА ---
#let exam_style(
  title: "Дискретная математика",
  subtitle: "Ответы на вопросы к экзамену",
  university: "Московский государственный университет",
  faculty: "Факультет шаурмечного дела",
  author: "Студент-красавчик",
  checker: "Преподаватель",
  group: "Группа ИУ6-7",
  year: "2026",
  body
) = {
  // Настройка страницы для основного документа (будет автоматически применяться после титульника и оглавления)
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    header: context {
      // Показывать верхний колонтитул только с 3-й страницы (после титульника и оглавления)
      let page-num = counter(page).get().first()
      if page-num > 2 {
        grid(
          columns: (1fr, 1fr),
          align(left)[#text(fill: luma(120), size: 9pt, font: "Libertinus Serif")[#title]],
          align(right)[#text(fill: luma(120), size: 9pt, font: "Libertinus Serif")[Вопросы к экзамену]]
        )
        v(0.2em)
        line(length: 100%, stroke: 0.5pt + luma(200))
      }
    },
    footer: context {
      // Показывать номер страницы только с 3-й страницы
      let page-num = counter(page).get().first()
      if page-num > 2 {
        align(center)[#text(size: 10pt, font: "Libertinus Serif")[#page-num]]
      }
    }
  )

  // Шрифт и общие настройки текста
  set text(font: "Libertinus Serif", size: 11pt, lang: "ru")
  set par(justify: true, leading: 0.7em)

  // Настройка заголовков разделов (level 1)
  show heading.where(level: 1): it => block(
    width: 100%,
    above: 2em,
    below: 1.5em,
    breakable: false,
    [
      #v(0.5cm)
      #text(size: 16pt, weight: "bold", fill: rgb("1c7ed6"))[#it.body]
      #v(-0.2em)
      #line(length: 100%, stroke: 2pt + rgb("1c7ed6"))
    ]
  )

  // Настройка заголовков вопросов (level 2)
  show heading.where(level: 2): it => block(
    width: 100%,
    fill: luma(250),
    stroke: (left: 4pt + rgb("1c7ed6")),
    inset: (x: 12pt, y: 10pt),
    radius: (right: 4pt),
    above: 1.5em,
    below: 1em,
    breakable: false,
    [
      #text(size: 12pt, weight: "bold", fill: luma(30))[#it.body]
    ]
  )

  // 1. ТИТУЛЬНЫЙ ЛИСТ
  page(header: none, footer: none, margin: (x: 3cm, y: 3cm))[
    #set align(center)
    
    #if university != "" [
      #text(size: 10pt, weight: "bold", tracking: 1.5pt)[#upper(university)] \
      #if faculty != "" [
        #v(0.2em)
        #text(size: 9pt, fill: luma(100))[#faculty]
      ]
      #v(1cm)
      #line(length: 40%, stroke: 0.5pt + luma(180))
    ]
    
    #align(horizon)[
      #v(-2cm)
      #rect(
        width: 100%,
        stroke: (left: 4pt + rgb("1c7ed6")),
        fill: rgb("f1f3f5"),
        inset: 20pt,
        radius: (right: 6pt),
        align(left)[
          #text(size: 24pt, weight: "bold", fill: rgb("1c7ed6"))[#title] \
          #if subtitle != "" [
            #v(0.6em)
            #text(size: 13pt, style: "italic", fill: luma(80))[#subtitle]
          ]
        ]
      )
      
      #v(1.5cm)
      #text(size: 12pt, weight: "medium", tracking: 1pt, fill: luma(120))[ПОЛНЫЙ СВОД ОТВЕТОВ НА ВОПРОСЫ]
    ]
    
    #align(bottom)[
      #grid(
        columns: (1.2fr, 0.8fr),
        row-gutter: 1.2em,
        align(left)[
          #if author != "" [
            #text(size: 11pt)[
              *Выполнил студент:* \
              #author \
              #if group != "" [Группа: #group]
            ]
          ]
        ],
    
      )
      #v(2cm)
      #text(size: 10pt, fill: luma(100))[#year]
    ]
  ]

  // 2. ОГЛАВЛЕНИЕ
  page(header: none, footer: none)[
    #v(1cm)
    #align(center)[
      #text(size: 18pt, weight: "bold", fill: rgb("1c7ed6"))[Содержание]
    ]
    #v(1.5cm)
    
    #show outline.entry.where(level: 1): it => {
      v(14pt, weak: true)
      strong(text(fill: rgb("1c7ed6"))[#it])
    }
    
    #outline(title: none, indent: 1.5em)
  ]

  // 3. ОСНОВНОЙ ТЕКСТ
  body
}

// --- УМНЫЕ БЛОКИ ДЛЯ ТЕОРИИ ---

// Блок для Определений (светло-оранжевый)
#let def(term, body) = block(
  fill: rgb("fff5eb"),
  stroke: (left: 3pt + rgb("ff922b")),
  inset: 10pt,
  radius: (right: 4pt),
  width: 100%,
  [*Определение (#term):* #body],
)

// Блок для Теорем и Доказательств (светло-синий)
#let thm(name, body) = block(
  fill: rgb("#f3e8f8"),
  stroke: (left: 3pt + rgb("#9b33f0")),
  inset: 10pt,
  radius: (right: 4pt),
  width: 100%,
  [*Теорема (#name):* #body],
)

// Блок для Важных заметок (светло-красный)
#let alert(body) = block(
  fill: rgb("ffeeee"),
  stroke: (left: 3pt + rgb("ff6b6b")),
  inset: 10pt,
  radius: (right: 4pt),
  width: 100%,
  [*Важно:* #body],
)
