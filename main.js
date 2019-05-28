function decrement(price, pid) {
    
//    alert (price);
//    var qty = document.getElementById(pid).innerHTML;
    var qty = pid.innerHTML;
    var n = parseInt(qty, 10);
    if (n > 1) {
        n = n - 1;
//    document.getElementById(pid).innerHTML = String(n);
        pid.innerHTML = String(n);

        var total = document.getElementById("total").innerHTML;
        total = parseInt(total, 10);
        total -= price;
        total = total.toFixed(2);
        document.getElementById("total").innerHTML = total;
        document.getElementById("display").innerHTML = total;
    }
    
}

function increment(price, pid) {
//    var qty = document.getElementById(pid).innerHTML;
    var qty = pid.innerHTML;
    var n = parseInt(qty, 10);
    n = n + 1;
//    document.getElementById(pid).innerHTML = String(n);
    pid.innerHTML = String(n);
    
    var total = document.getElementById("total").innerHTML;
    total = parseInt(total, 10);
    total += price;
    total = total.toFixed(2);
    document.getElementById("total").innerHTML = total;
    document.getElementById("display").innerHTML = total;
}

function prompt_total(userid, total) {
    
    alert(userid);
    
}