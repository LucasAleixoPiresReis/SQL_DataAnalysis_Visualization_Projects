-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Especificações e preços de venda de notebooks
-- MAGIC 
-- MAGIC >**Entendo o problema:**
-- MAGIC * A primeira tarefa é gerar insights que ajudem os preços de notebooks com bases nas suas especificações técnicas.
-- MAGIC * Several different factors can affect laptop computer prices. These factors include the brand of computer and the number of options and add-ons included in the computer package. In addition, the amount of memory and the speed of the processor can also affect pricing. Though less common, some consumers spend additional money to purchase a computer based on the overall “look” and design of the system.
-- MAGIC * In many cases, name brand computers are more expensive than generic versions. This price increase often has more to do with name recognition than any actual superiority of the product. One major difference between name brand and generic systems is that in most cases, name brand computers offer better warranties than generic versions. Having the option of returning a computer that is malfunctioning is often enough of an incentive to encourage many consumers to spend more money.
-- MAGIC * Functionality is an important factor in determining laptop computer prices. A computer with more memory often performs better for a longer time than a computer with less memory. In addition, hard drive space is also crucial, and the size of the hard drive usually affects pricing. Many consumers may also look for digital video drivers and other types of recording devices that may affect the laptop computer prices.
-- MAGIC * Most computers come with some software pre-installed. In most cases, the more software that is installed on a computer, the more expensive it is. This is especially true if the installed programs are from well-established and recognizable software publishers. Those considering purchasing a new laptop computer should be aware that many of the pre-installed programs may be trial versions only, and will expire within a certain time period. In order to keep the programs, a code will need to be purchased, and then a permanent version of the software can be downloaded.
-- MAGIC * Many consumers who are purchasing a new computer are buying an entire package. In addition to the computer itself, these systems typically include a monitor, keyboard, and mouse. Some packages may even include a printer or digital camera. The number of extras included in a computer package usually affects laptop computer prices.
-- MAGIC * Some industry leaders in computer manufacturing make it a selling point to offer computers in sleek styling and in a variety of colors. They may also offer unusual or contemporary system design. Though this is less important to many consumers, for those who do value “looks,” this type of system may be well worth the extra cost.
-- MAGIC 
-- MAGIC 
-- MAGIC 
-- MAGIC The EDA helps you to know which features (fields) required for the analysis, if there are any outliers, any missing values, unique values, descriptive statistics (average, max and min values, standard deviation) which ofcourse depends on the scenarios - (i) if you are doing EDA to build predictive model (Machine Learning application) or (ii) to extract information for data-driven decisions making, depending on organization’s requirement, here I am explaining EDA for the scenario(ii) i.e., for data-driven decision making!

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Análise descritiva (SQL) 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Coleta dos dados
-- MAGIC * Um profissional da área de dados realizou a extração dos dados através de Coleta de dados web (Web Scraping) do site flipkart.com;
-- MAGIC * A ferramenta utilizada foi a extensão **Instant Data Scraper**, disponível para Chrome Web;
-- MAGIC * O conjunto de dados pode ser acessado através do link: https://www.kaggle.com/datasets/kuchhbhi/latest-laptop-price-list; 
-- MAGIC * O conjunto de dados é chamado neste projeto de **notebooks_schema**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Exploração e limpeza dos dados

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Visualizando o conjunto dados

-- COMMAND ----------

SELECT *
FROM notebook_sales

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **O conjunto de dados apresenta um total de:**
-- MAGIC * Linhas: 876
-- MAGIC * Colunas: 23 colunas (glossário)
-- MAGIC     * brand (marca)
-- MAGIC     * model (modelo)
-- MAGIC     * processor_brand (marca do processador)
-- MAGIC     * processor_name (nome do processador)
-- MAGIC     * processor_gnrtn (geração do processador)
-- MAGIC     * ram_gb (quantidade de RAM)
-- MAGIC     * ram_type (tipo de RAM)
-- MAGIC     * ssd
-- MAGIC     * hdd
-- MAGIC     * os (sistema operacional)
-- MAGIC     * os_bit
-- MAGIC     * graphic_card_gb
-- MAGIC     * weight (peso)
-- MAGIC     * display_size (tamanho tela)
-- MAGIC     * warranty (garantia)
-- MAGIC     * Touchscreen
-- MAGIC     * msoffice
-- MAGIC     * latest_price (preço atual)
-- MAGIC     * old_price (preço antigo)
-- MAGIC     * discount (desconto)
-- MAGIC     * star_rating (classificação por estrelas)
-- MAGIC     * ratings (classificações)
-- MAGIC     * reviews (avaliações)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Visualizando os tipos de dados do conjunto**

-- COMMAND ----------

DESCRIBE notebook_sales

-- COMMAND ----------

-- MAGIC %md
-- MAGIC O conjunto de dados possui **11** colunas com variáveis do tipo **string**, **4** colunas com variávieis do tipo **float** e **8** colunas do tipo **int**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Conferindo duplicatas

-- COMMAND ----------

-- MAGIC %md
-- MAGIC As duplicatas foram excluídas utilizando-se Python.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Conferindo valores faltantes e valores únicos de cada coluna

-- COMMAND ----------

-- MAGIC %md
-- MAGIC > ##### Atributos categóricos:

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Brand:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE brand IS NULL OR brand =''

-- COMMAND ----------

SELECT DISTINCT brand AS Marca
FROM notebook_sales

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Não há valores faltantes. A query apresenta um resutado de 21 marcas, mas percebemos que a marca Lenovo está registrada duas vezes (Lenovo e lenovo)
-- MAGIC * **1ª Alteração: Alterar as ocorrência de lenovo para Lenovo.** 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Model:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE model IS NULL OR model =''

-- COMMAND ----------

SELECT DISTINCT model AS Modelo
FROM notebook_sales
GROUP BY model

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Não há dados faltantes. A query apresenta 117 modelos diferentes, mas percebemos que **6** modelos estão grafados de diferentes formas, o que causa um erro no número de modelos distintos:
-- MAGIC    * Inspiron também aparece como (Insprion, Inpiron, INSPIRON);
-- MAGIC    * ROG também aparece como (Rog);
-- MAGIC   * IdeaPad também aparece como (Ideapad, IDEAPAD);
-- MAGIC   * Zenbook também aparece como (ZenBook);
-- MAGIC   * ThinkPad também aparece como (Thinpad, Thinkpad);
-- MAGIC   * ThinkBook tamém aparece como (Thinkbook).
-- MAGIC   
-- MAGIC * **2ª Alteração: Alterar as diferentes grafias dos 6 modelos apresentados.**

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Processor_brand:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE processor_brand IS NULL OR processor_brand =''

-- COMMAND ----------

SELECT DISTINCT processor_brand AS Marca_processador
FROM notebook_sales
GROUP BY processor_brand 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Não há dados faltantes. A query retornou 5 marcas de processadores distintas.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Processor_name:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE processor_name IS NULL OR processor_name =''

-- COMMAND ----------

SELECT DISTINCT processor_name AS Modelo_processador
FROM notebook_sales
GROUP BY processor_name

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Não há dados faltantes. A query apresenta 28, mas 3 observaçõe estão incorretas (GeForce GTX, GEFORCE RTX, GeForce RTX) por se tratarem de placas de vídeo.
-- MAGIC * **3ª Alteração: Substituir as ocorrências de (GeForce GTX, GEFORCE RTX, GeForce RTX) por 'Missing'.**

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Processor_gnrtn:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE processor_gnrtn IS NULL OR processor_gnrtn ='' 

-- COMMAND ----------

SELECT DISTINCT processor_gnrtn AS Geracao_processador
FROM notebook_sales
GROUP BY processor_gnrtn

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Não há dados faltantes ou nulos. 7 gerações distindas de processadores. O valor 0 correponde aos notebooks onde não se encontra essa informação.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **ram_gb:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE ram_gb IS NULL OR ram_gb = ''

-- COMMAND ----------

SELECT DISTINCT ram_gb
FROM notebook_sales
GROUP BY ram_gb

-- COMMAND ----------



-- COMMAND ----------

-- MAGIC %md
-- MAGIC Não há dados nulos ou faltantes. Foram retornados 4 quantidades distintas de memória RAM (4, 8, 16, 32).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **ram_type:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE ram_type IS NULL OR ram_type =''

-- COMMAND ----------

SELECT DISTINCT ram_type AS Tipo_RAM
FROM notebook_sales
GROUP BY ram_type

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Para fins de análise, serão considerados apenas 3 categorias de memória RAM (DDR3, DDR4, DDR5)
-- MAGIC * **4ª Alteração: Mudar os tipos (LPDDR4, LPDDR4X) para DDR4 e (LPDDR3) para DDR3.**

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **ssd:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE ssd IS NULL OR ssd =''

-- COMMAND ----------

SELECT DISTINCT ssd
FROM notebook_sales
GROUP BY ssd

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **hdd:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE hdd IS NULL OR hdd = ''

-- COMMAND ----------

SELECT DISTINCT hdd
FROM notebook_sales
GROUP BY hdd

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **os:**

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE os IS NULL OR os = ''

-- COMMAND ----------

SELECT DISTINCT os AS Sistema_operacional
FROM notebook_sales
GROUP BY os

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **os_bit:**

-- COMMAND ----------

SELECT DISTINCT os_bit AS SO_bit
FROM notebook_sales
GROUP BY os_bit

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **graphic_card_gb:**

-- COMMAND ----------

SELECT DISTINCT graphic_card_gb AS Memoria_placa_de_video
FROM notebook_sales
GROUP BY graphic_card_gb

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **weight:**

-- COMMAND ----------

SELECT DISTINCT weight AS Peso
FROM notebook_sales
GROUP BY weight

-- COMMAND ----------

SELECT DISTINCT display_size AS Tamanho_tela
FROM notebook_sales
GROUP BY display_size

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Touchscreen e msoffice**

-- COMMAND ----------

SELECT DISTINCT Touchscreen
FROM notebook_sales
GROUP BY Touchscreen;

-- COMMAND ----------

SELECT DISTINCT msoffice
FROM notebook_sales
GROUP BY msoffice;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **warranty:**

-- COMMAND ----------

SELECT DISTINCT warranty AS Garantia_anos
FROM notebook_sales
GROUP BY warranty

-- COMMAND ----------

-- MAGIC %md
-- MAGIC >##### Atributos numéricos contínuos

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **latest_price**
-- MAGIC   * Conferindo dados nulos, faltantes e valores fora da lógica de negócio

-- COMMAND ----------

SELECT *
FROM notebook_sales
WHERE latest_price IS NULL OR latest_price = '' OR latest_price <= 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **6ª Alteração: Os preços devem ser convertidos de Rupias indianas (₹) para Real(R$) e apresentar duas casas decimais.**

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **discount**

-- COMMAND ----------

SELECT
  MIN(discount)/100 AS Minimo_desconto,
  MAX(discount)/100 AS Maximo_desconto,
  AVG(discount)/100 AS Media_desconto
FROM notebook_sales

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **7ª Alteração: Os descontos devem ser alterados para valores decimais.**

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **star_rating, ratings e reviews**

-- COMMAND ----------

SELECT
  MIN(star_rating) AS Minimo_classificacao,
  MAX(star_rating) AS Maximo_classificacao,
  AVG(star_rating) AS Media_classificacao
FROM notebook_sales

-- COMMAND ----------

SELECT
  MIN(ratings) AS Minimo_Num_classificacoes,
  MAX(ratings) AS Maximo_Num_classificacoes,
  AVG(ratings) AS Media_Num_classificacoes
FROM notebook_sales

-- COMMAND ----------

SELECT
  MIN(reviews) AS Minimo_avaliacoes,
  MAX(reviews) AS Maximo_avaliacoes,
  AVG(reviews) AS Media_avaliacoes
FROM notebook_sales

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Aplicando as alterações
-- MAGIC Como conjunto apresenta um número pequeno de coluna, as alterações serão reladas de uma única vez em uma view. Assim, não alteraremos a origem das informações diretamente.

-- COMMAND ----------

CREATE VIEW notebook_sales_cleaned AS
  SELECT
    CASE WHEN brand = 'lenovo' THEN 'Lenovo'
         ELSE brand 
    END AS brand_fixed,
    CASE WHEN model = 'Thinkbook' THEN 'ThinkBook'
         WHEN model = 'ZenBook' THEN 'Zenbook'
         WHEN model = 'Rog' THEN 'ROG'
         WHEN model IN ('Thinpad', 'Thinkpad') THEN 'ThinkPad'
         WHEN model IN ('Ideapad', 'IDEAPAD') THEN 'IdeaPad'
         WHEN model IN ('Insprion', 'Inpiron', 'INSPIRON') THEN 'Inspiron'
         ELSE model
     END AS model_fixed,
     processor_brand,
     CASE WHEN processor_name IN ('GeForce GTX', 'GEFORCE RTX', 'GeForce RTX') THEN 'Missing'
          ELSE processor_name
     END AS processor_name_fixed,
     processor_gnrtn,
     ram_gb,
      CASE WHEN ram_type = 'LPDDR3' THEN 'DDR3'
           WHEN ram_type IN ('LPDDR4', 'LPDDR4X') THEN 'DDR4'
           ELSE ram_type
      END AS ram_type_fixed,
      ssd,
      hdd,
      os,
      os_bit,
      graphic_card_gb,
      weight,
      display_size,
      Touchscreen,
      msoffice,
      warranty,
      ROUND((latest_price * 0.066), 2) AS latest_price_real,
      ROUND((discount/100), 2) AS discount_decimal,
      star_rating,
      ratings,
      reviews
  FROM notebook_sales

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Conferindo as alterações:**

-- COMMAND ----------

SELECT *
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Analisando os dados

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Vendas
-- MAGIC * **Quantidade total**

-- COMMAND ----------

SELECT COUNT(*) AS Total_vendas
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Preços de venda
-- MAGIC * **Mínimo, máximo, média dos preços**

-- COMMAND ----------

SELECT 
  MIN(latest_price_real) AS Menor_preco,
  MAX(latest_price_real) AS Maior_preco,
  ROUND(AVG(latest_price_real), 2) AS Media_preco
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Distribuição do preço de venda**

-- COMMAND ----------

SELECT latest_price_real
FROM notebook_sales_cleanednotebooks_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Classificações

-- COMMAND ----------

-- MAGIC %md
-- MAGIC É necessário  que exista pelo menos 1 classificação (ratings) para que exista Classificação (0-5) (star_rating)

-- COMMAND ----------

SELECT 
  COUNT(*) 
FROM notebook_sales_cleaned
WHERE star_rating = 0 AND ratings != 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Dessa forma, o número existente de classificações dentro do conjunto é:

-- COMMAND ----------

SELECT COUNT(ratings) AS Num_classificacoes, COUNT(star_rating) AS Num_star_rating
FROM notebook_sales_cleaned
WHERE ratings != 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Marcas
-- MAGIC * **Quantidade de marcas no conjunto de vendas**
-- MAGIC * **Todas as marcas do conjunto**

-- COMMAND ----------

SELECT 
  COUNT(DISTINCT brand_fixed) AS Numero_marcas
FROM notebook_sales_cleaned

-- COMMAND ----------

SELECT brand_fixed AS Marcas
FROM notebook_sales_cleaned
GROUP BY Marcas

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Quantidade de notebooks vendidos por marca**

-- COMMAND ----------

SELECT
  brand_fixed AS Marca,
  COUNT(*) AS Unidades
FROM notebook_sales_cleaned
GROUP BY brand_fixed
ORDER BY Unidades DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Porcentagem de vendas por marcas (5 mais vendidas)**

-- COMMAND ----------

SELECT
  brand_fixed AS Marca,
  ROUND(((COUNT(*) * 100)/876), 2) AS Porcentagem
FROM notebook_sales_cleaned
GROUP BY brand_fixed
ORDER BY Porcentagem DESC
LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Valor total de vendas e Mínimo, máximo e média dos preços de venda por marca**

-- COMMAND ----------

SELECT 
  brand_fixed AS Marca,
  ROUND(SUM(latest_price_real), 2) AS Valor_total_vendas,
  MIN(latest_price_real) AS Minimo_preco,
  MAX(latest_price_real) AS Maximo_preco,
  ROUND(AVG(latest_price_real), 2) AS Media_preco
FROM notebook_sales_cleanednotebooks_cleaned
GROUP BY Marca

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Distribuição do preço por marca**

-- COMMAND ----------

SELECT 
  brand_fixed,
  latest_price_real
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Marcas que vendem notebooks caros no mercado**
-- MAGIC   
-- MAGIC   Com base na distribuição do preço. Considerando os outliers (> R$ 10257,13). O maior preço é da Alienware.
-- MAGIC   
-- MAGIC   Número de outliers por marca: total são 53

-- COMMAND ----------

SELECT 
  brand_fixed AS Marca,
  COUNT(*) AS Quantidade_preco_elevado
FROM notebook_sales_cleaned
WHERE latest_price_real > 10257.13
GROUP BY brand_fixed
ORDER BY Quantidade_preco_elevado DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Classificação (0-5) média por marca**

-- COMMAND ----------

SELECT
  brand_fixed AS Marca,
  ROUND(AVG(star_rating), 2) AS Media_class,
  (SELECT ROUND(AVG(star_rating), 2)
   FROM notebook_sales_cleaned) AS Media_geral
FROM notebook_sales_cleaned
GROUP BY brand_fixed

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Memória RAM
-- MAGIC * **Quantidades distintas de memória RAM**
-- MAGIC * **Tipos de memória RAM**

-- COMMAND ----------

SELECT DISTINCT ram_gb AS Quantidade_RAM
FROM notebook_sales_cleaned

-- COMMAND ----------

SELECT DISTINCT ram_type_fixed
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Número de vendas por quantidade de memória RAM**

-- COMMAND ----------

SELECT 
  ram_gb AS Quantidade_RAM,
  COUNT(*) AS Quantidade_notebooks
FROM notebook_sales_cleaned
GROUP BY Quantidade_RAM

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Número de vendas por tipo de memória RAM**

-- COMMAND ----------

SELECT
  ram_type_fixed AS Tipo_RAM,
  COUNT(*) AS Quantidade_RAM
FROM notebook_sales_cleaned
GROUP BY Tipo_RAM

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Quantidade de vendas por quantidade de memória e por tipo de memória**

-- COMMAND ----------

SELECT 
  ram_gb AS Quantidade_RAM,
  ram_type_fixed,
  COUNT(*) AS Quantidade_notebooks
FROM notebook_sales_cleaned
GROUP BY Quantidade_RAM, ram_type_fixed

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Mínimo, Máximo e Média dos preços dos notebooks por quantidade de memória RAM**

-- COMMAND ----------

SELECT
  ram_gb AS GB_RAM,
  ROUND(MIN(latest_price_real), 2) AS Minimo_preco_venda,
  ROUND(MAX(latest_price_real), 2) AS Maximo_preco_venda,
  ROUND(AVG(latest_price_real), 2) AS Media_preco_venda
FROM notebook_sales_cleaned
GROUP BY GB_RAM
ORDER BY GB_RAM

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Distribuição do preço de venda dos notebooks por quantidade de memória RAM**

-- COMMAND ----------

SELECT
  ram_gb AS GB_RAM,
  latest_price_real AS Preco_venda
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Mínimo, Máximo e Média dos preços dos notebooks por tipo de memória RAM**

-- COMMAND ----------

SELECT
  ram_type_fixed AS Tipo_RAM,
  ROUND(MIN(latest_price_real), 2) AS Minimo_preco_venda,
  ROUND(MAX(latest_price_real), 2) AS Maximo_preco_venda,
  ROUND(AVG(latest_price_real), 2) AS Media_preco_venda
FROM notebook_sales_cleaned
GROUP BY Tipo_RAM
ORDER BY Tipo_RAM

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Distribuição do preço de venda dos notebooks por tipo de memória RAM**

-- COMMAND ----------

SELECT
  ram_type_fixed,
  latest_price_real
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### SSD e HDD
-- MAGIC * Quantidade de vendas de notebooks por tipo de armazenamento (ssd, hdd, hibrido)

-- COMMAND ----------

SELECT
  CASE WHEN ssd = 0 AND hdd != 0 THEN 'ssd'
       WHEN ssd != 0 AND hdd = 0 THEN 'hdd'
       WHEN ssd != 0 AND hdd != 0 THEN 'hibrido'
  END AS Tipo_armazenamento,
  COUNT(*) AS Quantidade_tipo_armazenamento
FROM notebook_sales_cleaned
GROUP BY Tipo_armazenamento
ORDER BY Quantidade_tipo_armazenamento

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Mínimo, Máximo e Média de preço por tipo de armazenamento (ssd, hdd, hibrido)**

-- COMMAND ----------

SELECT
  CASE WHEN ssd = 0 AND hdd != 0 THEN 'ssd'
       WHEN ssd != 0 AND hdd = 0 THEN 'hdd'
       WHEN ssd != 0 AND hdd != 0 THEN 'hibrido'
  END AS Tipo_armazenamento,
  ROUND(MIN(latest_price_real), 2) AS Minimo_preco_tipo_armazenamento,
  ROUND(MAX(latest_price_real), 2) AS Maximo_preco_tipo_armazenamento,
  ROUND(AVG(latest_price_real), 2) AS Media_preco_tipo_armazenamento
FROM notebook_sales_cleaned
GROUP BY Tipo_armazenamento

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Distribuição dos preços por tipo de armazenamento**

-- COMMAND ----------

SELECT
  CASE WHEN ssd = 0 AND hdd != 0 THEN 'ssd'
       WHEN ssd != 0 AND hdd = 0 THEN 'hdd'
       WHEN ssd != 0 AND hdd != 0 THEN 'hibrido'
  END AS tipo_armazenamento,
  latest_price_real
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Sistema operacional
-- MAGIC * **Tipos de sistema operacional**

-- COMMAND ----------

SELECT DISTINCT os AS Sistema_operacional
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Quantidade de vendas por sistema operacional**

-- COMMAND ----------

SELECT 
  os AS Sistema_operacional,
  COUNT(*) AS Quantidade_vendas
FROM notebooks_cleaned
GROUP BY Sistema_operacional

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Min, Max e Média dos preços dos notebooks por sistema operacional**

-- COMMAND ----------

SELECT
  os AS Sistema_operacional,
  ROUND(MIN(latest_price_real), 2) AS Minimo_preco_Sistema_Operacional,
  ROUND(MAX(latest_price_real), 2) AS Maximo_preco_Sistema_Operacional,
  ROUND(AVG(latest_price_real), 2) AS Media_preco_Sistema_Operacional
FROM notebook_sales_cleaned
GROUP BY Sistema_operacional

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Distribuição dos preços por Sistema operacional**

-- COMMAND ----------

SELECT
  os AS Sistema_operacional,
  latest_price_real
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Processador
-- MAGIC * **Marcas dos processadores e número de vendas**

-- COMMAND ----------

SELECT 
  processor_brand AS Marca,
  COUNT(*) AS Quantidade_vendas
FROM notebook_sales_cleaned
GROUP BY Marca
ORDER BY Quantidade_vendas DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Quantidade de diferentes modelos de processadores**

-- COMMAND ----------

SELECT COUNT(DISTINCT processor_name_fixed) AS Quantidade_modelos_processador
FROM notebook_sales_cleaned

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **5 modelos de processadores mais vendidos**

-- COMMAND ----------

SELECT
  processor_name_fixed AS Modelo_processador,
  COUNT(*) AS Quantidade_vendas
FROM notebook_sales_cleaned
GROUP BY Modelo_processador
ORDER BY Quantidade_vendas DESC
LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Tipos de geração dos processadores**

-- COMMAND ----------

SELECT DISTINCT processor_gnrtn
FROM notebook_sales_cleaned

-- COMMAND ----------

SELECT 
  processor_gnrtn AS Geracao_processador, 
  COUNT(*) AS Quantidade_vendas
FROM notebook_sales_cleaned
GROUP BY processor_gnrtn

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Correlações entre preço e classificação por especificações técnicas

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **5 marcas com mais vendas**

-- COMMAND ----------

SELECT
  latest_price_real AS Preco,
  star_rating AS Classificacao_estrela,
  brand_fixed AS Marca
FROM notebook_sales_cleaned
WHERE ratings != 0 AND brand_fixed IN ('ASUS', 'DELL', 'Lenovo', 'HP', 'acer')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Quantidade de memória RAM**

-- COMMAND ----------

SELECT
  latest_price_real AS Preco,
  star_rating AS Classificacao_estrela,
  ram_gb AS Capacidade_RAM
FROM notebook_sales_cleaned
WHERE ratings != 0

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * **Tipo de armazenamento**

-- COMMAND ----------

SELECT
  latest_price_real AS Preco,
  star_rating AS Classificacao_estrela,
  (SELECT
    CASE WHEN ssd = 0 AND hdd != 0 THEN 'ssd'
         WHEN ssd != 0 AND hdd = 0 THEN 'hdd'
         WHEN ssd != 0 AND hdd != 0 THEN 'hibrido'
    END) AS tipo_armazenamento
FROM notebook_sales_cleaned
WHERE ratings != 0
