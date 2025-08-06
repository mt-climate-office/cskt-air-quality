# Download Daily US EPA PM<sub>2.5</sub> AQI Data for a PurpleAir Sensor

This guide shows how to configure PurpleAir map settings, select your sensor, and export daily AQI data as CSV.

---

## 1. Open the Map to a Sensor & Configuration Settings

![PurpleAir map](./overview.png) 

1. Visit: [https://map.purpleair.com](https://map.purpleair.com), or select a sensor from [https://mt-climate-office.github.io/cskt-air-quality/](https://mt-climate-office.github.io/cskt-air-quality/).
2. Click the **gear icon** (⚙) at the top‑left to open the configuration menu.  
![Configuration Menu Screenshot](./config.png) 
3. Set your map options:
   - **Data layer** → `US EPA PM2.5 (AQI)`
   - **Apply conversion** → `US EPA`
   - **Averaging period** → `1‑day`

***Note:*** *Data can be downloaded for shorter averaging periods (e.g., 15-minute), but shorter averaging periods will download shorter timeseries. `1-day` will download a year of data.*

---

## 2. Select Your Sensor & View Its Graph

![Graph & Popup Screenshot](./graph.png) 

- Search for your sensor or manually zoom to its location. 
- Click the colored marker for the sensor—this opens a popup with the EPA‐corrected AQI graph and sensor details.

---

## 3. Download the Graph Data

![Download CSV Screenshot](./download.png) 

- Inside the graph popup, click the **menu icon** (☰) on the upper right corner of the graph.
- Choose **Download CSV** or **Download XLS**.
- This exports graph data matching the current layer, conversion, and averaging settings.

---

## 4. Use the Sensor Data Download Tool (for longer timeseries)

![Download Tool Screenshot](./download_tool.png) 

- Alternatively, click the **Data** dropdown above the map, and select the [**Data Download Tool**](https://community.purpleair.com/t/purpleair-data-download-tool/).
- Follow the instructions to install the tool, register for a PurpleAir API account, and download longer timeseries.

---

## 5. Interpret Your CSV Data

Each downloaded file includes:
- **UTC timestamps** (automatically converted to date-time fields by Excel)
- The long-term (annual) **Average** of the data
- **EPA AQI** values

---

## 6. Bookmark for Future Use

- Bookmark the map URL with your preferred settings (layer, conversion, averaging)—this preserves view and configuration.

---

## 📋 Steps Summary

| Step | Action |
|------|--------|
| 1 | Open PurpleAir map and open settings panel |
| 2 | Set Data Layer → US EPA PM<sub>2.5</sub> AQI; Apply conversion → US EPA; Averaging → 1‑day |
| 3 | Click your sensor dot → view popup graph |
| 4 | Click graph menu → Download CSV/XLS |
| 5 | (Optional) Use Download Tool for longer exports |
| 6 | Convert timestamps to local time |
| 7 | Bookmark configured map or log in for private sensors |

---

### ℹ️ Tips & Limitations

- **Graph CSV downloads** are limited by the averaging period:
  - **1‑day average** → maximum ~1 year
  - **Hourly/real‑time** → limited days only
- For full-resolution raw data or longer time spans, consider using the **PurpleAir API or Data Download Tool** (requires API keys).
