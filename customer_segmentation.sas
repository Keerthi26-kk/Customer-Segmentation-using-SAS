/* Generated Code (IMPORT) */
/* Source File: data.csv */
/* Source Path: /home/u64242476 */
/* Code generated on: 30/05/2025 05:40 */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u64242476/data.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

DATA WORK.CLEAN_DATA;
    SET WORK.IMPORT;

    /* If PurchaseDate is character, convert it */
    IF VTYPE(PurchaseDate) = 'C' THEN DO;
        ConvertedDate = INPUT(PurchaseDate, ANYDTDTE.);
        FORMAT ConvertedDate DATE9.;
    END;
    ELSE DO;
        ConvertedDate = PurchaseDate;
    END;

    FORMAT ConvertedDate DATE9.;
    RENAME ConvertedDate = PurchaseDate;
RUN;

PROC SQL;
    CREATE TABLE WORK.RFM_CALC AS
    SELECT 
        CustomerID,
        MAX(PurchaseDate) AS LastPurchase FORMAT=DATE9.,
        COUNT(DISTINCT OrderID) AS Frequency,
        SUM(TransactionAmount) AS Monetary
    FROM WORK.CLEAN_DATA
    GROUP BY CustomerID;
QUIT;

PROC SQL NOPRINT;
    SELECT MAX(PurchaseDate) INTO :MaxDate
    FROM WORK.CLEAN_DATA;
QUIT;
DATA WORK.RFM;
    SET WORK.RFM_CALC;
    Recency = INT(&MaxDate - LastPurchase);
RUN;
PROC RANK DATA=WORK.RFM OUT=WORK.RFM_RANK GROUPS=5;
    VAR Recency;
    RANKS R_Score;
RUN;

PROC RANK DATA=WORK.RFM_RANK OUT=WORK.RFM_RANK GROUPS=5;
    VAR Frequency;
    RANKS F_Score;
RUN;

PROC RANK DATA=WORK.RFM_RANK OUT=WORK.RFM_RANK GROUPS=5;
    VAR Monetary;
    RANKS M_Score;
RUN;
DATA WORK.RFM_FINAL;
    SET WORK.RFM_RANK;
    R_Score = 5 - R_Score;
    F_Score = F_Score + 1;
    M_Score = M_Score + 1;
    RFM_Score = CATS(R_Score, F_Score, M_Score);
RUN;

DATA WORK.SEGMENTS;
    SET WORK.RFM_FINAL;
    LENGTH Segment $20.;
    IF R_Score >=4 AND F_Score >=4 AND M_Score >=4 THEN Segment = "Champions";
    ELSE IF R_Score >=3 AND F_Score >=3 AND M_Score >=3 THEN Segment = "Loyal Customers";
    ELSE IF R_Score >=4 THEN Segment = "Recent Customers";
    ELSE IF F_Score >=4 THEN Segment = "Frequent Buyers";
    ELSE IF M_Score >=4 THEN Segment = "Big Spenders";
    ELSE Segment = "Others";
RUN;
PROC PRINT DATA=WORK.SEGMENTS (OBS=20);
    TITLE "Customer Segmentation using RFM Analysis";
RUN;

%web_open_table(WORK.SEGMENTS);
