CREATE TABLE TiffHeader (
   Tag  WORD PRIMARY KEY,
   Name VARCHAR
);

CREATE INDEX;

INSERT INTO TiffHeader VALUES (255,'SubfileType');
INSERT INTO TiffHeader VALUES (256,'ImageWidth');
INSERT INTO TiffHeader VALUES (257,'ImageLength');
INSERT INTO TiffHeader VALUES (258,'BitsPerSample');
INSERT INTO TiffHeader VALUES (259,'Compression');
INSERT INTO TiffHeader VALUES (262,'PhotometricInterp');
INSERT INTO TiffHeader VALUES (263,'Threshholding');
INSERT INTO TiffHeader VALUES (264,'CellWidth');
INSERT INTO TiffHeader VALUES (265,'CellLength');
INSERT INTO TiffHeader VALUES (266,'FillOrder');
INSERT INTO TiffHeader VALUES (269,'DocumentName');
INSERT INTO TiffHeader VALUES (270,'ImageDescription');
INSERT INTO TiffHeader VALUES (271,'Make');
INSERT INTO TiffHeader VALUES (272,'Model');
INSERT INTO TiffHeader VALUES (273,'StripOffsets');
INSERT INTO TiffHeader VALUES (274,'Orientation');
INSERT INTO TiffHeader VALUES (277,'SamplesPerPixel');
INSERT INTO TiffHeader VALUES (278,'RowsPerStrip');
INSERT INTO TiffHeader VALUES (279,'StripByteCounts');
INSERT INTO TiffHeader VALUES (280,'MinSampleValue');
INSERT INTO TiffHeader VALUES (281,'MaxSampleValue');
INSERT INTO TiffHeader VALUES (282,'XResolution');
INSERT INTO TiffHeader VALUES (283,'YResolution');
INSERT INTO TiffHeader VALUES (284,'PlanarConfiguration');
INSERT INTO TiffHeader VALUES (285,'PageName');
INSERT INTO TiffHeader VALUES (286,'XPosition');
INSERT INTO TiffHeader VALUES (287,'YPosition');
INSERT INTO TiffHeader VALUES (288,'FreeOffsets');
INSERT INTO TiffHeader VALUES (289,'FreeByteCounts');
INSERT INTO TiffHeader VALUES (290,'GrayResponseUnit');
INSERT INTO TiffHeader VALUES (291,'GrayResponseCurves');
INSERT INTO TiffHeader VALUES (292,'Group3Options');
INSERT INTO TiffHeader VALUES (293,'Group4Options');
INSERT INTO TiffHeader VALUES (296,'ResolutionUnit');
INSERT INTO TiffHeader VALUES (297,'PageNumber');
INSERT INTO TiffHeader VALUES (300,'ColorResponseUnit');
INSERT INTO TiffHeader VALUES (301,'ColorResponseCurves');