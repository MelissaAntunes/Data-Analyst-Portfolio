SELECT *
	FROM portfolio_project.dbo.NashvilleHousing;

------------------------------------------------
-- Preenchendo dados no Property Address

SELECT *
	FROM portfolio_project.dbo.NashvilleHousing
	--WHERE PropertyAddress IS NULL
	ORDER BY ParcelID

SELECT 
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	ISNULL(a.PropertyAddress, b.PropertyAddress)
	FROM portfolio_project.dbo.NashvilleHousing a
		JOIN portfolio_project.dbo.NashvilleHousing b
			ON a.ParcelID = b.ParcelID
			AND a.UniqueID <> b.UniqueID
	WHERE a.PropertyAddress IS NULL

UPDATE a
	SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
	FROM portfolio_project.dbo.NashvilleHousing a
		JOIN portfolio_project.dbo.NashvilleHousing b
			ON a.ParcelID = b.ParcelID
			AND a.UniqueID <> b.UniqueID
	WHERE a.PropertyAddress IS NULL

-----------------------------------------------------------
-- Dividindo o endereço em colunas individuais (Address, City, State)

SELECT 
	PropertyAddress
	FROM portfolio_project.dbo.NashvilleHousing
	--WHERE PropertyAddress IS NULL
	--ORDER BY ParcelID

SELECT
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
	FROM portfolio_project.dbo.NashvilleHousing

ALTER TABLE portfolio_project.dbo.NashvilleHousing
	ADD PropertySplitAddress NVARCHAR(255)

UPDATE portfolio_project.dbo.NashvilleHousing
	SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE portfolio_project.dbo.NashvilleHousing
	ADD PropertySplitCity NVARCHAR(255)

UPDATE portfolio_project.dbo.NashvilleHousing
	SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT *
	FROM portfolio_project.dbo.NashvilleHousing

----------------------------------------------------
-- Outra maneira de dividir uma coluna

SELECT
	OwnerAddress
	FROM portfolio_project.dbo.NashvilleHousing

SELECT 
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
	FROM portfolio_project.dbo.NashvilleHousing

ALTER TABLE portfolio_project.dbo.NashvilleHousing
	ADD OwnerSplitAddress NVARCHAR(255)

UPDATE portfolio_project.dbo.NashvilleHousing
	SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE portfolio_project.dbo.NashvilleHousing
	ADD OwnerSplitCity NVARCHAR(255)

UPDATE portfolio_project.dbo.NashvilleHousing
	SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE portfolio_project.dbo.NashvilleHousing
	ADD OwnerSplitState NVARCHAR(255)

UPDATE portfolio_project.dbo.NashvilleHousing
	SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

SELECT *
	FROM portfolio_project.dbo.NashvilleHousing

------------------------------------------------------
-- Mudando '0' e '1' para 'No' e 'Yes' na campo 'Sold as Vacant'

SELECT DISTINCT(SoldAsVacant)
	FROM portfolio_project.dbo.NashvilleHousing

SELECT 
	SoldAsVacant,
	CASE WHEN CAST(SoldAsVacant AS VARCHAR) = '0' THEN 'No'
		WHEN CAST(SoldAsVacant AS VARCHAR) = '1' THEN 'Yes'
	ELSE CAST(SoldAsVacant AS VARCHAR)
	END
	FROM portfolio_project.dbo.NashvilleHousing

-- Criando uma nova coluna no tipo varchar para poder armazenar 'yes e 'no'
ALTER TABLE portfolio_project.dbo.NashvilleHousing
ADD SoldAsVacantText VARCHAR(3);

UPDATE portfolio_project.dbo.NashvilleHousing
	SET SoldAsVacantText = CASE WHEN CAST(SoldAsVacant AS VARCHAR) = '0' THEN 'No'
							WHEN CAST(SoldAsVacant AS VARCHAR) = '1' THEN 'Yes'
							ELSE CAST(SoldAsVacant AS VARCHAR)
							END
	
SELECT SoldAsVacantText
	FROM portfolio_project.dbo.NashvilleHousing

----------------------------------------------------------------
-- Removendo duplicatas

WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID ) row_num
	FROM portfolio_project.dbo.NashvilleHousing
)
--DELETE
SELECT *
	FROM RowNumCTE
	WHERE row_num > 1 

------------------------------------------------------------
-- Deletar colunas não utilizadas

ALTER TABLE portfolio_project.dbo.NashvilleHousing
DROP COLUMN PropertyAddress,
			OwnerAddress,
			SoldAsVacant

SELECT *
FROM portfolio_project.dbo.NashvilleHousing
