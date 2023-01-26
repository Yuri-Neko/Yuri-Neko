import axios from "axios"
import PDFDocument from "pdfkit"
import { extractImageThumb } from "@adiwajshing/baileys"
import fetch from "node-fetch"
let handler = async(m, { conn, text }) => {
try {
if (!text) throw 'Input url' 
	await m.reply('_In progress, please wait..._')
let dat = await fetch(`https://api.itsrose.my.id/manga/kiryuu/chapter?url=${text}`)
let data = await dat.json()
let pages = []
let thumb = `https://external-content.duckduckgo.com/iu/?u=${data.content[0]}`	
data.map((v) => {
			pages.push(`https://external-content.duckduckgo.com/iu/?u=${v.content}`)
		})
let buffer = await (await fetch(thumb)).buffer()		
let jpegThumbnail = await extractImageThumb(buffer)		
let imagepdf = await toPDF(pages)		
await conn.sendMessage(m.chat, { document: imagepdf, jpegThumbnail, fileName: data.title + '.pdf', mimetype: 'application/pdf' }, { quoted: m })
} catch {
await m.reply("url Invailid")
}
} 
handler.command = /^(kiryuupdf|krpdf)$/i
handler.tags = ['nsfw']
handler.help = [' <code> ']
export default handler 


function toPDF(images, opt = {}) {
	return new Promise(async (resolve, reject) => {
		if (!Array.isArray(images)) images = [images]
		let buffs = [], doc = new PDFDocument({ margin: 0, size: 'A4' })
		for (let x = 0; x < images.length; x++) {
			if (/.webp|.gif/.test(images[x])) continue
			let data = (await axios.get(images[x], { responseType: 'arraybuffer', ...opt })).data
			doc.image(data, 0, 0, { fit: [595.28, 841.89], align: 'center', valign: 'center' })
			if (images.length != x + 1) doc.addPage()
		}
		doc.on('data', (chunk) => buffs.push(chunk))
		doc.on('end', () => resolve(Buffer.concat(buffs)))
		doc.on('error', (err) => reject(err))
		doc.end()
	})
}
