USE QLCB
GO
--Q34. Cho	biết hãng	sản	xuất,	mã	loại	và	số hiệu	của máy	bay	đã	được	sử dụng	nhiều	nhất.
SELECT LMB.HANGSX, MB.MALOAI, MB.SOHIEU
FROM LOAIMB LMB JOIN MAYBAY MB ON LMB.MALOAI = MB.MALOAI
	JOIN (SELECT LB.MALOAI,LB.SOHIEU, COUNT(LB.MACB) SCB
			FROM LICHBAY LB
			GROUP BY  LB.MALOAI, LB.SOHIEU) AS SCB ON SCB.MALOAI = MB.MALOAI AND SCB.SOHIEU = MB.SOHIEU
WHERE SCB.SCB >= ALL (SELECT COUNT(LB2.MACB) SCB
						FROM LICHBAY LB2
						GROUP BY  LB2.MALOAI, LB2.SOHIEU)

--Q35. Cho	biết tên nhân viên được	phân Công đi	nhiều	chuyến	bay	nhất.
SELECT NV.MANV,NV.TEN
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
GROUP BY NV.MANV,NV.TEN
HAVING COUNT(PC.MACB) >= ALL(SELECT COUNT(PC2.MACB)
							FROM PHANCONG PC2
							GROUP BY PC2.MANV)
--Q36. Cho	biết	thông	tin	của	phi	công (tên,	địa	chỉ,	điện	thoại)	lái	nhiều	chuyến	bay	nhất.
SELECT NV.MANV,NV.TEN
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
WHERE NV.LOAINV = 1
GROUP BY NV.MANV,NV.TEN, NV.DCHI, NV.DTHOAI
HAVING COUNT(PC.MACB) >= ALL(SELECT COUNT(PC2.MACB)
							FROM PHANCONG PC2 JOIN NHANVIEN NV2 ON NV2.MANV = PC2.MANV
							WHERE NV2.LOAINV = 1
							GROUP BY PC2.MANV)
--Q37. Cho	biết sân bay (SBDEN) và	số lượng	chuyến	bay	của	sân	bay	có	ít	chuyến	bay	đáp	 xuống	nhất.
SELECT CB.SBDEN, COUNT(CB.MACB) SLCB
FROM CHUYENBAY CB
GROUP BY CB.SBDEN
HAVING COUNT(CB.MACB) <= ALL(SELECT COUNT(CB2.MACB) 
								FROM CHUYENBAY CB2
								GROUP BY CB2.SBDEN)
--Q38. Cho	biết sân bay (SBDI)	và	số lượng	chuyến	bay	của	sân	bay	có	nhiều	chuyến	bay	xuất	phát	nhất.SELECT CB.SBDEN, COUNT(CB.MACB) SLCB
SELECT CB.SBDI, COUNT(CB.MACB) SLCB
FROM CHUYENBAY CB
GROUP BY CB.SBDI
HAVING COUNT(CB.MACB) >= ALL(SELECT COUNT(CB2.MACB) 
								FROM CHUYENBAY CB2
								GROUP BY CB2.SBDI)
--Q39. Cho	biết tên, địa chỉ,	và	điện	thoại	của	khách	hàng	đã	đi	trên	nhiều chuyến bay	nhất.
SELECT KH.TEN, KH.DCHI, KH.DTHOAI, COUNT(DC.MACB) SLCB
FROM KHACHHANG KH JOIN DATCHO DC ON KH.MAKH = DC.MAKH
GROUP BY KH.MAKH, KH.TEN, KH.DCHI, KH.DTHOAI
HAVING COUNT(DC.MACB) >= ALL(SELECT COUNT(DC2.MACB)
							FROM DATCHO DC2
							GROUP BY DC2.MAKH)
--Q40. Cho	biết mã	số,	tên	và	lương	của	các	phi	công	có	khả năng	lái	nhiều	loại	máy	bay	nhất.
SELECT NV.MANV, NV.TEN, NV.LUONG
FROM NHANVIEN NV JOIN KHANANG KN ON NV.MANV= KN.MANV
WHERE NV.LOAINV = 1
GROUP BY NV.MANV, NV.TEN, NV.LUONG
HAVING COUNT(KN.MALOAI) >= ALL(SELECT COUNT(KN2.MALOAI)
								FROM KHANANG KN2
								GROUP BY KN2.MANV)
--Q41. Cho	biết	thông	tin	(mã	nhân	viên,	tên,	lương)	của	nhân	viên	có	mức	lương	cao	nhất.
SELECT NV.MANV, NV.TEN, NV.LUONG
FROM NHANVIEN NV
WHERE NV.LUONG >= ALL(SELECT NV2.LUONG
						FROM NHANVIEN NV2)
--Q42. Cho	biết tên, địa chỉ của các nhân viên có lương cao nhất trong	phi	hành đoàn 
--(các nhân viên được phân công	trong một chuyến	bay)	mà	người	đó	tham	gia.
SELECT PC.MACB, NV.TEN, NV.DCHI
FROM PHANCONG PC JOIN NHANVIEN NV ON NV.MANV = PC.MANV
WHERE NV.LUONG <= ALL(SELECT NV2.LUONG
						FROM PHANCONG PC2 JOIN NHANVIEN NV2 ON NV2.MANV = PC2.MANV
						WHERE PC.MACB = PC2.MACB)

--Q43. Cho	biết mã chuyến bay,	giờ đi	và giờ đến của chuyến bay	bay	sớm nhất trong	ngày.
SELECT LB.NGAYDI, LB.MACB, CB.GIODI
FROM LICHBAY LB JOIN CHUYENBAY CB ON LB.MACB = CB.MACB
WHERE CB.GIODI <= ALL(SELECT CB2.GIODI
						FROM  LICHBAY LB2 JOIN CHUYENBAY CB2 ON LB2.MACB = CB2.MACB
						WHERE LB2.NGAYDI = LB.NGAYDI)

--Q44. Cho	biết mã	chuyến bay	có thời gian	bay	dài nhất.	Xuất	ra	mã	chuyến	bay	và	thời	gian	 bay	
--(tính	bằng	phút).
SELECT CB.MACB, CB.TGB
FROM (SELECT* , ((DATEPART(HOUR,CB.GIODEN) - DATEPART(HOUR,CB.GIODI))*60 + (DATEPART(MINUTE,CB.GIODEN) - DATEPART(MINUTE,CB.GIODI))) AS TGB
		FROM CHUYENBAY CB) CB 
WHERE CB.TGB >= ALL(SELECT ((DATEPART(HOUR,CB2.GIODEN) - DATEPART(HOUR,CB2.GIODI))*60 + (DATEPART(MINUTE,CB2.GIODEN) - DATEPART(MINUTE,CB2.GIODI))) AS TGB
							FROM CHUYENBAY CB2)
--Q45. Cho	biết mã	chuyến bay	có thời gian	bay	ít	nhất.	Xuất	ra	mã	chuyến	bay	và	thời	gian	bay.
SELECT CB.MACB, CB.TGB
FROM (SELECT* , ((DATEPART(HOUR,CB.GIODEN) - DATEPART(HOUR,CB.GIODI))*60 + (DATEPART(MINUTE,CB.GIODEN) - DATEPART(MINUTE,CB.GIODI))) AS TGB
		FROM CHUYENBAY CB) CB 
WHERE CB.TGB <= ALL(SELECT ((DATEPART(HOUR,CB2.GIODEN) - DATEPART(HOUR,CB2.GIODI))*60 + (DATEPART(MINUTE,CB2.GIODEN) - DATEPART(MINUTE,CB2.GIODI))) AS TGB
							FROM CHUYENBAY CB2)
--Q46. Cho	biết mã chuyến bay	và ngày đi	của những chuyến bay bay trên loại máy bay	B747 nhiều nhất.
SELECT LB.MACB, LB.NGAYDI
FROM LICHBAY LB JOIN MAYBAY MB ON MB.MALOAI = LB.MALOAI AND LB.SOHIEU = MB.SOHIEU
WHERE MB.MALOAI = 'B747'

--Q47. Với	mỗi	chuyến	bay	có	trên	3	hành	khách,	cho	biết	mã	chuyến	bay	và	số lượng	nhân	
--viên	trên	chuyến	bay	đó.	Xuất	ra mã	chuyến	bay	và	số lượng	nhân	viên.
SELECT PC.MACB, COUNT(PC.MANV) SLNV
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
GROUP BY PC.MACB
HAVING PC.MACB IN (SELECT DC.MACB
					FROM KHACHHANG KH JOIN DATCHO DC ON KH.MAKH = DC.MAKH
					GROUP BY DC.MACB
					HAVING COUNT(KH.MAKH) > 3)
--Q48. Với	mỗi	loại	nhân	viên	có	tổng	lương	trên	600000,	cho	biết	số lượng	nhân	viên	trong	
--từng	loại	nhân	viên	đó.	Xuất	ra	loại	nhân	viên,	và	số lượng	nhân	viên	tương	ứng.
SELECT NV.LOAINV, COUNT(NV.MANV) AS SLNV
FROM NHANVIEN NV
GROUP BY NV.LOAINV
HAVING SUM(NV.LUONG)  > 600000

--Q49. Với	mỗi	chuyến	bay	có	trên	3	nhân	viên,	cho	biết	mã	chuyến	bay	và	số lượng	khách	
--hàng	đã	đặt	chỗ trên	chuyến	bay	đó.
SELECT DC.MACB, COUNT(DC.MAKH) SLKH
FROM KHACHHANG KH JOIN DATCHO DC ON KH.MAKH = DC.MAKH
GROUP BY DC.MACB
HAVING DC.MACB IN (SELECT PC.MACB
					FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
					GROUP BY PC.MACB
					HAVING COUNT(PC.MANV) > 3)
--Q50. Với	mỗi	loại	máy	bay	có	nhiều	hơn	một	chiếc,	cho	biết	số lượng	chuyến	bay	đã	được	bố
--trí	bay	bằng	loại	máy	bay	đó.	Xuất	ra	mã	loại	và	số lượng.
SELECT LB.MALOAI, COUNT(LB.MACB) SLMB
FROM LICHBAY LB
GROUP BY LB.MALOAI
HAVING COUNT(LB.MACB)  > 1
