document.addEventListener('DOMContentLoaded', () => {
  // 価格入力フィールドを取得
  const priceInput = document.getElementById("item-price");
  
  // 販売手数料と利益を表示するエリアを取得
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  // 価格が入力された際の処理
  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value); // 入力された価格を整数に変換

    if (!isNaN(price) && price >= 300 && price <= 9999999) { // 価格が範囲内かどうかをチェック
      const fee = Math.floor(price * 0.1); // 販売手数料（10%）を計算し、小数点以下を切り捨て
      const netProfit = Math.floor(price - fee); // 販売利益を計算し、小数点以下を切り捨て

      addTaxPrice.textContent = fee; // 手数料を表示
      profit.textContent = netProfit; // 利益を表示
    } else {
      addTaxPrice.textContent = ''; // 範囲外の価格の場合、表示をクリア
      profit.textContent = '';
    }
  });
});
