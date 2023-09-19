use master 
go

use QLCB
go

--Q17. Với	mỗi	sân	bay	(SBDEN), cho biết số lượng	chuyến	bay	hạ cánh xuống sân bay đó. Kết	
--quả được sắp	xếp	theo thứ tự tăng dần của sân bay đến.

SELECT SBDEN, COUNT(MACB) AS SLCBDEN
FROM CHUYENBAY
GROUP BY SBDEN
ORDER BY SBDEN ASC

--Q18. Với	mỗi	sân	bay	(SBDI),	cho	biết số lượng	chuyến	bay	xuất	phát	từ sân	bay	đó,	sắp	xếp	
--theo	thứ tự tăng	dần của	sân	bay xuất phát.

SELECT SBDI, COUNT(MACB) AS SLCBDI
FROM CHUYENBAY
GROUP BY SBDI
ORDER BY SBDI ASC

--Q19. Với	mỗi	sân	bay	(SBDI),	cho	biết số lượng chuyến bay xuất phát theo	từng ngày. Xuất	ra	mã sân	bay	đi,	ngày và	số lượng.

SELECT CB.SBDI AS SBDI, LB.NGAYDI AS NGAYDI , COUNT(CB.MACB) AS SLCBDI
FROM CHUYENBAY  CB JOIN LICHBAY LB ON CB.MACB = LB.MACB
GROUP BY CB.SBDI, LB.NGAYDI

--Q20. Với	mỗi	sân	bay	(SBDEN), cho biết số lượng chuyến bay hạ cánh theo từng	ngày. Xuất ra mã sân bay đến, ngày và số lượng.

SELECT CB.SBDEN AS SBDEN, LB.NGAYDI AS NGAYDI , COUNT(CB.MACB) AS SLCBDI
FROM CHUYENBAY  CB JOIN LICHBAY LB ON CB.MACB = LB.MACB
GROUP BY CB.SBDEN, LB.NGAYDI

--Q21. Với	mỗi	lịch bay, cho biết mã chuyến bay, ngày đi cùng	với	số lượng nhân viên không phải là phi công của chuyến bay đó.

SELECT LB.MACB, LB.NGAYDI, COUNT(NV.MANV) AS SLNV 
FROM LICHBAY LB JOIN (PHANCONG PC  JOIN NHANVIEN NV ON PC.MANV = NV.MANV) ON LB.MACB = PC.MACB
WHERE NV.LOAINV = 0
GROUP BY LB.MACB, LB.NGAYDI

--Q22. Số lượng	chuyến	bay	xuất	phát	từ sân	bay	MIA	vào	ngày	11/01/2000.

SELECT SBDI, COUNT(LB.MACB) AS SLCBDI
FROM CHUYENBAY CB JOIN LICHBAY LB ON LB.MACB = CB.MACB
WHERE CB.SBDI = 'MIA' AND LB.NGAYDI = '2000-11-01'
GROUP BY SBDI

--Q23. Với	mỗi	chuyến	bay, cho biết mã chuyến	bay, ngày đi, số lượng nhân	viên được phân công trên chuyến	bay	đó,	sắp	theo thứ tự giảm dần của số lượng.

SELECT LB.MACB, LB.NGAYDI, COUNT(NV.MANV) AS SLNV 
FROM LICHBAY LB JOIN (PHANCONG PC  JOIN NHANVIEN NV ON PC.MANV = NV.MANV) ON LB.MACB = PC.MACB
GROUP BY LB.MACB, LB.NGAYDI
ORDER BY SLNV DESC

--Q24. Với	mỗi	chuyến	bay, cho biết mã chuyến	bay, ngày đi, cùng với số lượng	hành khách đã đặt chỗ của chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.

SELECT LB.MACB, LB.NGAYDI, COUNT(KH.MAKH) AS SLKH
FROM DATCHO DC, KHACHHANG KH, LICHBAY LB
WHERE DC.MAKH = KH.MAKH AND LB.MACB = DC.MACB
GROUP BY LB.MACB, LB.NGAYDI
ORDER BY SLKH DESC

--Q25. Với	mỗi	chuyến	bay,	cho	biết	mã	chuyến	bay,	ngày	đi,	tổng	lương	của	phi	hành	đoàn	
--(các	nhân viên	được phân	công	trong	chuyến	bay), sắp	xếp	theo thứ tự tăng	dần	của	tổng lương.

SELECT LB.MACB, LB.NGAYDI, SUM(NV.LUONG) AS TONGLUONG
FROM LICHBAY LB JOIN (PHANCONG PC  JOIN NHANVIEN NV ON PC.MANV = NV.MANV) ON LB.MACB = PC.MACB
GROUP BY LB.MACB, LB.NGAYDI
ORDER BY TONGLUONG ASC

--Q26. Cho	biết lương	trung	bình	của	các	nhân	viên	không	phải	là	phi	công.

SELECT AVG(LUONG) LUONGTB
FROM NHANVIEN
WHERE LOAINV =0

--Q27. Cho	biết mức	lương	trung	bình	của	các	phi	công.

SELECT AVG(LUONG) LUONGTB
FROM NHANVIEN
WHERE LOAINV =1

--Q28. Với	mỗi	loại máy bay, cho biết số lượng	chuyến bay	đã	bay	trên loại máy bay đó hạ cánh xuống sân	bay	ORD.	
--Xuất	ra	mã	loại máy bay, số lượng	chuyến	bay.
SELECT LMB.MALOAI, COUNT(CB.MACB) SLCB
FROM LOAIMB LMB, LICHBAY LB, CHUYENBAY CB
WHERE LMB.MALOAI = LB.MALOAI AND LB.MACB = CB.MACB AND CB.SBDEN = 'ORD'
GROUP BY LMB.MALOAI

--Q29. Cho	biết sân bay (SBDI)	và số lượng	chuyến	bay	có	nhiều hơn 2	chuyến	bay	xuất phát trong	khoảng	10	giờ đến	22	giờ.

SELECT SBDI
FROM CHUYENBAY
WHERE DATEPART(HOUR, GIODI) BETWEEN 10 AND 22
GROUP BY SBDI
HAVING COUNT(MACB) >2

--Q30. Cho	biết tên phi công được phân	công vào ít	nhất 2	chuyến bay	trong cùng	một	ngày.

SELECT NV.TEN
FROM  PHANCONG PC JOIN NHANVIEN NV ON PC.MANV = NV.MANV
GROUP BY NV.MANV, NV.TEN
HAVING COUNT(PC.MACB) > 2

--Q31. Cho	biết mã	chuyến	bay	và	ngày đi	của	những	chuyến	bay	có	ít	hơn	3	hành	khách	đặt	chỗ.

SELECT LB.MACB, LB.NGAYDI
FROM DATCHO DC, KHACHHANG KH, LICHBAY LB
WHERE DC.MAKH = KH.MAKH AND LB.MACB = DC.MACB
GROUP BY LB.MACB, LB.NGAYDI
HAVING COUNT(KH.MAKH) < 3

--Q32. Cho	biết số hiệu máy bay và	loại máy bay mà	phi	công có mã 1001	được phân công lái trên	2 lần.

SELECT MB.SOHIEU
FROM MAYBAY MB, LICHBAY LB, PHANCONG PC, NHANVIEN NV
WHERE MB.MALOAI = LB.MALOAI AND LB.MACB = PC.MACB AND PC.MANV = NV.MANV AND NV.MANV = '1001'
GROUP BY NV.MANV, MB.SOHIEU
HAVING COUNT(LB.MACB) > 2

--Q33. Với	mỗi	hãng sản xuất, cho biết	số lượng loại máy bay mà hãng đó đã	sản	xuất. Xuất ra hãng sản xuất	và	số lượng.
SELECT LMB.HANGSX, COUNT(MB.SOHIEU) SLMB
FROM LOAIMB LMB JOIN MAYBAY MB ON LMB.MALOAI = MB.MALOAI
GROUP BY LMB.HANGSX