const price = () => {
  // 価格入力フィールドを取得
  const priceInput = document.getElementById("item-price");
  
  // 販売手数料と利益を表示するエリアを取得
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  // 価格が入力された際の処理
  priceInput.addEventListener('input', () => {
    const price = priceInput.value; 
    
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(price * 0.1);
    
    const profit = document.getElementById("profit");
    profit.innerHTML = Math.floor(price - (price * 0.1))
  })
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
