import '@material/web/all.js';

document.addEventListener('DOMContentLoaded', async () => {
    document.querySelectorAll('[unresolved]').forEach(el => el.removeAttribute('unresolved'));

    // exit button
    const exitBtn = document.getElementById('exit-btn');
    if (typeof window.ksu !== 'undefined' && typeof window.ksu.exit !== 'undefined') {
        exitBtn.onclick = () => ksu.exit()
    } else if (typeof window.webui !== 'undefined' && typeof window.webui.exit !== 'undefined') {
        exitBtn.onclick = () => webui.exit()
    } else {
        exitBtn.style.display = 'none';
    }
});
