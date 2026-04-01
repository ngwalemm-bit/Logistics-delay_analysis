{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww28600\viewh18000\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
SQL\
\
==================================================\
\'97Transport Mode Summary\
==================================================\
\
SELECT \
    transport_mode,\
    COUNT(*) AS total_shipments,\
    SUM(delay_days) AS total_delay_days,\
    ROUND(AVG(delay_days), 2) AS avg_delay_days\
FROM shipments\
GROUP BY transport_mode\
ORDER BY total_delay_days DESC;\
\
\
===================================================\
\'97Top Delayed Routes\
===================================================\
\
SELECT \
    route,\
    COUNT(*) AS total_shipments,\
    SUM(delay_days) AS total_delay_days,\
    ROUND(AVG(delay_days), 2) AS avg_delay_days\
FROM shipments\
GROUP BY route\
ORDER BY total_delay_days DESC\
LIMIT 10;\
\
\
===================================================\
---Carrier Performance\
===================================================\
\
SELECT \
    carrier,\
    COUNT(*) AS total_shipments,\
    SUM(delay_days) AS total_delay_days,\
    ROUND(AVG(delay_days), 2) AS avg_delay_days\
FROM shipments\
GROUP BY carrier\
ORDER BY avg_delay_days DESC;\
\
\
===================================================\
---Delay Reason Distribution\
===================================================\
\
SELECT \
    delay_reason,\
    COUNT(*) AS occurrences\
FROM shipments\
WHERE delay_reason IS NOT NULL\
GROUP BY delay_reason\
ORDER BY occurrences DESC;\
\
\
\
===================================================\
\'97Delays by Product\
===================================================\
\
SELECT \
    p.product_category,\
    COUNT(*) AS total_shipments,\
    SUM(s.delay_days) AS total_delay_days,\
    ROUND(AVG(s.delay_days), 2) AS avg_delay_days\
FROM shipments s\
JOIN products p\
    ON s.product_id = p.product_id\
GROUP BY p.product_category\
ORDER BY avg_delay_days DESC;}
