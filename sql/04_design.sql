-- CONSTRAINT FK_Nation_Region
--     FOREIGN KEY (regionkey) REFERENCES Region (regionkey)
--     ON DELETE CASCADE

-- ALTER TABLE TPCH.Nation
--     DROP FOREIGN KEY FK_Nation_Region,
--     ADD CONSTRAINT FK_Nation_Region FOREIGN KEY (regionkey)
--         REFERENCES TPCH.Region (regionkey) ON DELETE CASCADE;
