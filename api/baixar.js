import puppeteer from 'puppeteer';

export default async function handler(req, res) {
  try {
    const browser = await puppeteer.launch({
      args: ['--no-sandbox'],
      headless: true,
    });

    const page = await browser.newPage();
    await page.goto('https://onedrive.live.com/?ls=true&cid=D82992BFEEE0874A&id=D82992BFEEE0874A%21s80a236759e494466a94e483cb279f774&parId=root&o=OneUp');

    // Espera o botão "Baixar" aparecer
    await page.waitForSelector('[aria-label="Download"]', { timeout: 10000 });

    // Clica no botão
    await page.click('[aria-label="Download"]');

    // Aqui você pode aguardar o redirecionamento ou capturar o URL real
    // (OneDrive provavelmente inicia um download direto)

    // Você pode capturar o download ou simplesmente redirecionar o usuário
    // res.redirect(finalDownloadUrl)

    await browser.close();

    res.status(200).json({ message: 'Clique simulado com sucesso!' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao simular clique' });
  }
}
